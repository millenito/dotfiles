#!/bin/bash

# Global variables for SSH mode
SSH_MODE=false
SSH_TARGET=""

# Function to show usage
show_usage() {
    echo "Usage: $0 [--ssh user@hostname]"
    echo ""
    echo "Options:"
    echo "  --ssh user@hostname    Run this script on a remote server via SSH"
    echo "  -h, --help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                     Run locally"
    echo "  $0 --ssh root@example.com    Run on remote server"
}

# Function to parse arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --ssh)
                if [[ -z "$2" || "$2" =~ ^-- ]]; then
                    echo "Error: --ssh requires a user@hostname argument"
                    show_usage
                    exit 1
                fi
                SSH_MODE=true
                SSH_TARGET="$2"
                # Validate SSH target format
                if [[ ! "$SSH_TARGET" =~ ^[^@]+@[^@]+$ ]]; then
                    echo "Error: Invalid SSH target format. Use user@hostname"
                    exit 1
                fi
                shift 2
                ;;
            -h|--help)
                show_usage
                exit 0
                ;;
            *)
                echo "Error: Unknown argument '$1'"
                show_usage
                exit 1
                ;;
        esac
    done
}

# Function to execute script on remote server
execute_via_ssh() {
    local ssh_target="$1"
    local script_path="$0"
    local remote_script_path="/tmp/create_nginx_site_$(date +%s).sh"
    
    echo "Transferring script to remote server..."
    if ! scp "$script_path" "$ssh_target:$remote_script_path"; then
        echo "Error: Failed to transfer script to remote server"
        exit 1
    fi
    
    echo "Executing script on remote server: $ssh_target"
    echo "-----------------------------------------------"
    
    # Execute the script remotely with proper terminal handling
    if ssh -t "$ssh_target" "chmod +x '$remote_script_path' && '$remote_script_path' && rm -f '$remote_script_path'"; then
        echo "-----------------------------------------------"
        echo "Remote execution completed successfully"
    else
        echo "-----------------------------------------------"
        echo "Remote execution failed or was interrupted"
        # Attempt to clean up the remote script file
        ssh "$ssh_target" "rm -f '$remote_script_path'" 2>/dev/null
        exit 1
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to prompt user with y/n
prompt_yes_no() {
    while true; do
        read -p "$1 (y/n): " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

# Function to check if a port is in use (cross-platform attempt)
is_port_in_use() {
    local port="$1"
    # For macOS and Linux - netstat is common
    if command_exists netstat; then
        netstat -tuln | grep -q ":$port "
        return $?
    # Fallback for systems where lsof is more common or netstat is deprecated/different
    elif command_exists lsof; then
        lsof -i :"$port" -sTCP:LISTEN -P -n > /dev/null
        return $?
    else
        echo "Warning: Neither netstat nor lsof found. Cannot check if port $port is in use."
        return 1 # Assume not in use or let the user/application handle it
    fi
}

main() {
    # Check if running in SSH mode
    if [ "$SSH_MODE" = true ]; then
        execute_via_ssh "$SSH_TARGET"
        return $?
    fi

    echo "Nginx Site Configuration and Certbot SSL Setup"
    echo "-----------------------------------------------"

    # Check for Nginx and Certbot
    if ! command_exists nginx; then
        echo "Error: Nginx does not seem to be installed or not in PATH. Please install Nginx first."
        exit 1
    fi

    if ! command_exists certbot; then
        echo "Warning: Certbot does not seem to be installed or not in PATH. SSL setup will be skipped if you proceed without it."
        if ! prompt_yes_no "Do you want to continue without Certbot (SSL setup will be skipped)?"; then
            exit 1
        fi
    fi

    # Get website root directory
    read -e -p "Enter the full path to the website's root directory (e.g., /var/www/mysite): " SITE_ROOT
    if [ -z "$SITE_ROOT" ]; then
        echo "Error: Website root directory cannot be empty."
        exit 1
    fi
    if [ ! -d "$SITE_ROOT" ]; then
        if prompt_yes_no "Directory '$SITE_ROOT' does not exist. Create it now?" ; then
            sudo mkdir -p "$SITE_ROOT"
            sudo chown -R "$(whoami):$(whoami)" "$SITE_ROOT" # Or specific user/group like www-data
            echo "Directory '$SITE_ROOT' created."
        else
            echo "Continuing without creating the directory"
        fi
    fi

    # Get domain name
    read -p "Enter the domain name for the website (e.g., example.com): " DOMAIN_NAME
    if [ -z "$DOMAIN_NAME" ]; then
        echo "Error: Domain name cannot be empty."
        exit 1
    fi

    IS_LARAVEL_APP=false
    IS_STATIC_SPA=false
    IS_OCTANE_APP=false # New variable for Octane
    IS_REVERSE_PROXY=false # New variable for general reverse proxy
    OCTANE_PORT=8000 # Default Octane port
    REVERSE_PROXY_PORT=8000 # Default reverse proxy port
    SUPERVISOR_PROGRAM_NAME=""
    LARAVEL_PROJECT_PATH_FOR_SUPERVISOR=""
    OCTANE_COMMAND_FOR_SUPERVISOR=""
    SUPERVISOR_USER=""

    if prompt_yes_no "Is this a Laravel application?"; then
        IS_LARAVEL_APP=true
        SITE_ROOT_DISPLAY="$SITE_ROOT" 
        LARAVEL_PROJECT_PATH_FOR_SUPERVISOR="$SITE_ROOT" # Initial guess for supervisor path
        SITE_ROOT="$SITE_ROOT/public" # Default for non-Octane Laravel
        echo "Laravel app detected."

        if prompt_yes_no "Is this Laravel application using Octane?"; then
            IS_OCTANE_APP=true
            SHOULD_ENABLE_PHP=false # Octane handles PHP via its own server
            IS_STATIC_SPA=false # Octane is not a static SPA
            echo "Laravel Octane app detected. Nginx will be configured as a reverse proxy."
            
            while true; do
                read -p "Enter the port your Octane application will run on (default: 8000): " USER_OCTANE_PORT
                OCTANE_PORT_TO_CHECK=${USER_OCTANE_PORT:-8000}

                if [[ ! "$OCTANE_PORT_TO_CHECK" =~ ^[0-9]+$ ]]; then
                    echo "Error: Port must be a number."
                    continue
                fi

                if is_port_in_use "$OCTANE_PORT_TO_CHECK"; then
                    echo "Error: Port $OCTANE_PORT_TO_CHECK is already in use. Please choose a different port."
                else
                    OCTANE_PORT=$OCTANE_PORT_TO_CHECK
                    break
                fi
            done
            
            echo "Octane port set to: $OCTANE_PORT"
            # For Octane, Nginx root / public dir isn't directly served for PHP files, but might be for assets if not proxied
            # However, typical Octane setup proxies everything. We'll remove the /public adjustment for root later if Octane.
            SITE_ROOT="$SITE_ROOT_DISPLAY" # Octane proxies to the app, root is less critical for Nginx itself
        else
            # Regular Laravel (non-Octane) - adjust document root to public
            echo "Document root for non-Octane Laravel set to: $SITE_ROOT"
            if [ ! -d "$SITE_ROOT" ]; then
                echo "Warning: Laravel public directory '$SITE_ROOT' does not exist."
                if prompt_yes_no "Do you want to create it (assuming '$SITE_ROOT_DISPLAY' is the Laravel project root)?"; then
                    sudo mkdir -p "$SITE_ROOT"
                    sudo chown -R "$(whoami):$(whoami)" "$SITE_ROOT"
                    echo "Directory '$SITE_ROOT' created."
                else
                    echo "Continuing without creating the directory"
                fi
            fi
        fi
    else # Not Laravel
        if prompt_yes_no "Is this a static Single Page Application (e.g., Vue, React, Angular build)?"; then
            IS_STATIC_SPA=true
            SHOULD_ENABLE_PHP=false
            echo "Static SPA detected. PHP processing will be disabled and specific try_files will be used."
        elif prompt_yes_no "Is this config for a reverse proxy for a running service?"; then
            IS_REVERSE_PROXY=true
            SHOULD_ENABLE_PHP=false
            echo "Reverse proxy detected. Nginx will be configured as a reverse proxy."
            
            while true; do
                read -p "Enter the port your service is running on (default: 8000): " USER_REVERSE_PROXY_PORT
                REVERSE_PROXY_PORT_TO_CHECK=${USER_REVERSE_PROXY_PORT:-8000}

                if [[ ! "$REVERSE_PROXY_PORT_TO_CHECK" =~ ^[0-9]+$ ]]; then
                    echo "Error: Port must be a number."
                    continue
                fi

                REVERSE_PROXY_PORT=$REVERSE_PROXY_PORT_TO_CHECK
                break;
            done
            
            echo "Reverse proxy port set to: $REVERSE_PROXY_PORT"
        fi
    fi

    # Nginx configuration paths (common for Debian/Ubuntu)
    # Adjust if your Nginx setup is different (e.g., /etc/nginx/conf.d/ on CentOS/RHEL or Homebrew on macOS)
    NGINX_SITES_AVAILABLE="/etc/nginx/sites-available"
    NGINX_SITES_ENABLED="/etc/nginx/sites-enabled"
    CONFIG_FILE_PATH="$NGINX_SITES_AVAILABLE/$DOMAIN_NAME"

    # Check if Nginx config paths exist (for non-standard systems like macOS with brew)
    IS_MACOS=false
    if [[ "$(uname)" == "Darwin" ]]; then
        IS_MACOS=true
        # Try to find Homebrew Nginx config path
        BREW_PREFIX=$(brew --prefix nginx 2>/dev/null)
        if [ -n "$BREW_PREFIX" ]; then
            NGINX_CONF_DIR="$BREW_PREFIX/etc/nginx/servers"
            # macOS with Homebrew typically uses a single conf.d like directory or individual files in servers/
            # We'll place the config directly where it can be included.
            if [ ! -d "$NGINX_CONF_DIR" ]; then 
                sudo mkdir -p "$NGINX_CONF_DIR"
            fi 
            CONFIG_FILE_PATH="$NGINX_CONF_DIR/$DOMAIN_NAME.conf"
            echo "Detected macOS with Homebrew Nginx. Config will be placed at: $CONFIG_FILE_PATH"
        else
            echo "Warning: Could not determine Homebrew Nginx path. Assuming standard Linux paths."
            echo "You might need to adjust NGINX_SITES_AVAILABLE and NGINX_SITES_ENABLED paths manually."
        fi
    fi

    if [ -f "$CONFIG_FILE_PATH" ]; then
        echo "Error: Nginx configuration file '$CONFIG_FILE_PATH' already exists."
        if ! prompt_yes_no "Overwrite existing file?"; then
            exit 1
        fi
    fi

    echo "Creating Nginx server block configuration for $DOMAIN_NAME..."

    PHP_FPM_CONF=""
    STATIC_ASSETS_CONF=""
    NGINX_LOCATION_BLOCK=""

    if [ "$IS_OCTANE_APP" = true ]; then
        NGINX_LOCATION_BLOCK="\
    location / {
        proxy_pass http://127.0.0.1:${OCTANE_PORT};
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }"
        SITE_ROOT_CONFIG="# Root directive is not strictly necessary when proxying all requests for Octane\n    # root $SITE_ROOT; # You might configure this if serving some static assets directly via Nginx"
        INDEX_CONFIG="# Index directive is not strictly necessary when proxying all requests for Octane"

    elif [ "$IS_REVERSE_PROXY" = true ]; then
        NGINX_LOCATION_BLOCK="\
    location / {
        proxy_pass http://127.0.0.1:${REVERSE_PROXY_PORT};
        proxy_request_buffering off;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;

        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;

        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection \"upgrade\";
    }"
        SITE_ROOT_CONFIG="# Root directive is not strictly necessary when proxying all requests\n    # root $SITE_ROOT; # You might configure this if serving some static assets directly via Nginx"
        INDEX_CONFIG="# Index directive is not strictly necessary when proxying all requests"

    else # Not Octane or Reverse Proxy (could be Laravel non-Octane, Static SPA, or PHP app)
        SITE_ROOT_CONFIG="root $SITE_ROOT;"
        INDEX_CONFIG="index index.html index.htm index.php;"
        # Determine if PHP should be enabled (Laravel non-Octane apps always need PHP, static SPAs and reverse proxies never do)
        SHOULD_ENABLE_PHP=$IS_LARAVEL_APP # True if Laravel non-Octane, false otherwise initially
        if [ "$IS_LARAVEL_APP" = false ] && [ "$IS_STATIC_SPA" = false ] && [ "$IS_REVERSE_PROXY" = false ]; then # If not Laravel and not Static SPA and not Reverse Proxy
            if prompt_yes_no "Do you want to enable PHP processing for this site (e.g., for WordPress, other PHP apps)?"; then
                SHOULD_ENABLE_PHP=true
            fi
        fi

        if [ "$SHOULD_ENABLE_PHP" = true ]; then
            if command_exists php; then
                PHP_VERSION_FULL=$(php -v | head -n 1 | cut -d ' ' -f 2)
                PHP_VERSION_SHORT=$(echo "$PHP_VERSION_FULL" | cut -d '.' -f 1,2)
                FPM_SOCK_PATH="unix:/var/run/php/php${PHP_VERSION_SHORT}-fpm.sock"
                # macOS Homebrew PHP-FPM socket path checks (as before)
                if [[ "$(uname)" == "Darwin" ]]; then
                    if [ -S "/usr/local/var/run/php${PHP_VERSION_SHORT}-fpm.sock" ]; then FPM_SOCK_PATH="unix:/usr/local/var/run/php${PHP_VERSION_SHORT}-fpm.sock";
                    elif [ -S "/opt/homebrew/var/run/php${PHP_VERSION_SHORT}-fpm.sock" ]; then FPM_SOCK_PATH="unix:/opt/homebrew/var/run/php${PHP_VERSION_SHORT}-fpm.sock";
                    elif [ -S "/opt/homebrew/var/run/php-fpm.sock" ]; then FPM_SOCK_PATH="unix:/opt/homebrew/var/run/php-fpm.sock"; fi
                fi
                echo "PHP version $PHP_VERSION_SHORT detected. Configuring PHP-FPM socket to: $FPM_SOCK_PATH"
                PHP_FPM_CONF="\
    location ~ \\.php\$ {
        fastcgi_pass ${FPM_SOCK_PATH};
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$realpath_root\$fastcgi_script_name;
    }"
            else
                echo "PHP command not found. PHP-FPM configuration will be commented out."
                PHP_FPM_CONF="# PHP-FPM config commented out... (as before)"
            fi
        fi

        LOCATION_BLOCK_TRY_FILES='try_files $uri $uri/ =404;'
        if [ "$IS_LARAVEL_APP" = true ]; then # This is Laravel non-Octane
            LOCATION_BLOCK_TRY_FILES='try_files $uri $uri/ /index.php?$query_string;'
        elif [ "$IS_STATIC_SPA" = true ]; then
            LOCATION_BLOCK_TRY_FILES='try_files $uri $uri/ /index.html;'
            STATIC_ASSETS_CONF="\

    location ~* \\.(js|css|png|jpg|jpeg|gif|svg|ico|woff2?|ttf|eot)\$ {
        expires 6M;
        access_log off;
        add_header Cache-Control \"public\";
    }"
        fi
        NGINX_LOCATION_BLOCK="\
    location / {
        ${LOCATION_BLOCK_TRY_FILES}
    }"
    fi

    cat << EOF | sudo tee "$CONFIG_FILE_PATH" > /dev/null
server {
    listen 80;
    listen [::]:80;

    server_name $DOMAIN_NAME;
    ${SITE_ROOT_CONFIG}

    ${INDEX_CONFIG}

${NGINX_LOCATION_BLOCK}

${PHP_FPM_CONF}${STATIC_ASSETS_CONF}

    location ~ /\\.ht {
        deny all;
    }
}
EOF

    echo "Nginx configuration file created at $CONFIG_FILE_PATH"

    if [ "$IS_MACOS" = false ]; then
        # Create symbolic link for Linux systems
        if [ -L "$NGINX_SITES_ENABLED/$DOMAIN_NAME" ]; then
            echo "Symbolic link $NGINX_SITES_ENABLED/$DOMAIN_NAME already exists."
        else
            sudo ln -s "$CONFIG_FILE_PATH" "$NGINX_SITES_ENABLED/"
            echo "Symbolic link created in $NGINX_SITES_ENABLED"
        fi
    fi

    echo "Testing Nginx configuration..."
    if sudo nginx -t; then
        echo "Nginx configuration test successful."
        echo "Reloading Nginx to apply changes..."
        if [[ "$IS_MACOS" = true && -n "$BREW_PREFIX" ]]; then
            sudo brew services reload nginx
        else
            sudo systemctl reload nginx
        fi
    else
        echo "Error: Nginx configuration test failed. Please review $CONFIG_FILE_PATH and Nginx error logs."
        if [ "$IS_MACOS" = false ] && [ -L "$NGINX_SITES_ENABLED/$DOMAIN_NAME" ]; then # Check if symlink exists before trying to remove
             echo "You may need to remove the symlink: sudo rm $NGINX_SITES_ENABLED/$DOMAIN_NAME"
        fi
        exit 1
    fi

    # Supervisor configuration for Octane
    if [ "$IS_OCTANE_APP" = true ] && command_exists supervisorctl; then
        echo "-----------------------------------------------"
        echo "Supervisor Configuration for Laravel Octane"
        echo "-----------------------------------------------"
        
        DEFAULT_SUPERVISOR_PROGRAM_NAME=$(echo "$DOMAIN_NAME" | tr '.' '-' )"-octane"
        read -e -p "Enter Supervisor program name (default: $DEFAULT_SUPERVISOR_PROGRAM_NAME): " SUPERVISOR_PROGRAM_NAME_INPUT
        SUPERVISOR_PROGRAM_NAME=${SUPERVISOR_PROGRAM_NAME_INPUT:-$DEFAULT_SUPERVISOR_PROGRAM_NAME}

        read -e -p "Enter the full path to the Laravel project directory for Supervisor (e.g., $SITE_ROOT_DISPLAY): " LARAVEL_PROJECT_PATH_FOR_SUPERVISOR_INPUT
        LARAVEL_PROJECT_PATH_FOR_SUPERVISOR=${LARAVEL_PROJECT_PATH_FOR_SUPERVISOR_INPUT:-$SITE_ROOT_DISPLAY}

        DEFAULT_OCTANE_COMMAND="/usr/bin/php artisan octane:start --host=127.0.0.1 --port=${OCTANE_PORT}" # Example, user should verify PHP path
        echo "Example Octane command: $DEFAULT_OCTANE_COMMAND"
        read -e -p "Enter the exact command to start Octane (ensure PHP path is correct): " OCTANE_COMMAND_FOR_SUPERVISOR_INPUT
        OCTANE_COMMAND_FOR_SUPERVISOR=${OCTANE_COMMAND_FOR_SUPERVISOR_INPUT:-$DEFAULT_OCTANE_COMMAND}

        DEFAULT_SUPERVISOR_USER=$(whoami)
        read -e -p "Enter the username to run the Octane process as (default: $DEFAULT_SUPERVISOR_USER): " SUPERVISOR_USER_INPUT
        SUPERVISOR_USER=${SUPERVISOR_USER_INPUT:-$DEFAULT_SUPERVISOR_USER}

        DEFAULT_SUPERVISOR_LOG_DIR="$LARAVEL_PROJECT_PATH_FOR_SUPERVISOR/storage/logs" 
        read -e -p "Enter the directory for Supervisor log files (default: $DEFAULT_SUPERVISOR_LOG_DIR): " SUPERVISOR_LOG_DIR_INPUT
        SUPERVISOR_LOG_DIR=${SUPERVISOR_LOG_DIR_INPUT:-$DEFAULT_SUPERVISOR_LOG_DIR}

        SUPERVISOR_CONF_DIR="/etc/supervisor/conf.d" # Linux default
        if [[ "$(uname)" == "Darwin" ]]; then
            BREW_PREFIX_SUPERVISOR=$(brew --prefix supervisor 2>/dev/null)
            if [ -n "$BREW_PREFIX_SUPERVISOR" ]; then
                SUPERVISOR_CONF_DIR="$BREW_PREFIX_SUPERVISOR/etc/supervisor.d"
            else
                 echo "Warning: Could not determine Homebrew supervisor path. Assuming $SUPERVISOR_CONF_DIR for Supervisor config."
            fi
        fi
        
        if [ ! -d "$SUPERVISOR_CONF_DIR" ]; then
            echo "Warning: Supervisor config directory $SUPERVISOR_CONF_DIR does not exist. Creating it with sudo."
            sudo mkdir -p "$SUPERVISOR_CONF_DIR"
        fi

        if [ ! -d "$SUPERVISOR_LOG_DIR" ]; then
            echo "Log directory $SUPERVISOR_LOG_DIR does not exist. Creating it."
            sudo mkdir -p "$SUPERVISOR_LOG_DIR"
            sudo chown -R "$SUPERVISOR_USER":"$(id -g -n $SUPERVISOR_USER)" "$SUPERVISOR_LOG_DIR" # Ensure supervisor user can write logs
        fi 

        SUPERVISOR_CONF_FILE_PATH="$SUPERVISOR_CONF_DIR/$SUPERVISOR_PROGRAM_NAME.conf"

        echo "Creating Supervisor configuration file at $SUPERVISOR_CONF_FILE_PATH..."
        SUPERVISOR_CONFIG_CONTENT="[program:$SUPERVISOR_PROGRAM_NAME]
directory=$LARAVEL_PROJECT_PATH_FOR_SUPERVISOR
command=$OCTANE_COMMAND_FOR_SUPERVISOR
autostart=true
autorestart=true
stderr_logfile=$SUPERVISOR_LOG_DIR/$SUPERVISOR_PROGRAM_NAME.err.log
stdout_logfile=$SUPERVISOR_LOG_DIR/$SUPERVISOR_PROGRAM_NAME.out.log
user=$SUPERVISOR_USER"

        echo "$SUPERVISOR_CONFIG_CONTENT" | sudo tee "$SUPERVISOR_CONF_FILE_PATH" > /dev/null

        echo "Supervisor configuration file created."
        
        if prompt_yes_no "Do you want to attempt to update and start the Supervisor process now?"; then
            echo "Running Supervisor commands..."
            sudo supervisorctl reread
            sudo supervisorctl update
            sudo supervisorctl start "$SUPERVISOR_PROGRAM_NAME"
            echo "Supervisor commands executed. Check status with: sudo supervisorctl status $SUPERVISOR_PROGRAM_NAME"
        else
            echo "Please run the following commands manually to update Supervisor:"
            echo "  sudo supervisorctl reread"
            echo "  sudo supervisorctl update"
            echo "  sudo supervisorctl start $SUPERVISOR_PROGRAM_NAME"
        fi
        echo "Ensure your Octane application is configured to run on 127.0.0.1:$OCTANE_PORT"

    elif [ "$IS_OCTANE_APP" = true ]; then
        echo "Supervisor (supervisorctl) not found. Skipping Supervisor configuration for Octane."
        echo "Please configure a process manager like Supervisor manually to keep your Octane server running."
    fi

    # Run Certbot
    if command_exists certbot; then
        if prompt_yes_no "Do you want to run Certbot to obtain an SSL certificate for $DOMAIN_NAME?"; then
            echo "Running Certbot for $DOMAIN_NAME..."
            # For www and non-www, Certbot usually handles this if server_name includes both
            sudo certbot --nginx -d "$DOMAIN_NAME" 
            echo "Certbot process finished. Check its output for status."
        fi
    else
        echo "Certbot is not installed. Skipping SSL setup."
        echo "You can install Certbot and then run 'sudo certbot --nginx -d $DOMAIN_NAME' manually."
    fi

    echo "Script finished. Your site $DOMAIN_NAME should be configured."
    echo "Make sure your DNS records for $DOMAIN_NAME point to this server's IP address."

} # This is the closing brace for main()

# Parse command line arguments
parse_arguments "$@"

# Call main function
main
