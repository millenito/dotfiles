#!/bin/bash

# Function to detect OS and set package manager
detect_os_and_package_manager() {
    if [[ "$(uname)" == "Darwin" ]]; then
        OS="macos"
        PKG_MANAGER="brew"
        UPDATE_CMD="brew update"
        INSTALL_CMD="brew install"
        SUDO_CMD=""
    elif grep -q -E "(Ubuntu|Debian)" /etc/os-release; then
        OS="debian_ubuntu"
        PKG_MANAGER="apt-get"
        UPDATE_CMD="sudo apt-get update && apt-get upgrade"
        INSTALL_CMD="sudo apt-get install -y"
        SUDO_CMD="sudo"
    elif grep -q -E "(CentOS|RHEL|Rocky|AlmaLinux)" /etc/os-release; then
        OS="rhel_centos"
        PKG_MANAGER="yum"
        UPDATE_CMD="sudo yum check-update"
        INSTALL_CMD="sudo yum install -y"
        SUDO_CMD="sudo"
    elif grep -q -E "(Fedora)" /etc/os-release; then
        OS="fedora"
        PKG_MANAGER="dnf"
        UPDATE_CMD="sudo dnf check-update"
        INSTALL_CMD="sudo dnf install -y"
        SUDO_CMD="sudo"
    elif grep -q -E "(Arch Linux)" /etc/os-release; then
        OS="arch"
        PKG_MANAGER="pacman"
        UPDATE_CMD="sudo pacman -Syu"
        INSTALL_CMD="sudo pacman -S --noconfirm"
        SUDO_CMD="sudo"
    else
        echo "Unsupported OS. Exiting."
        exit 1
    fi
    echo "Detected OS: $OS, Package Manager: $PKG_MANAGER"
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

main() {
    detect_os_and_package_manager

    echo "1. Updating repository and packages, installing vim and curl..."
    $UPDATE_CMD
    $INSTALL_CMD vim curl
    echo "Vim and curl installation complete."

    # 2. Install Nginx (prompt first)
    if prompt_yes_no "Do you want to install Nginx?"; then
        echo "Installing Nginx..."
        $INSTALL_CMD nginx
        echo "Nginx installation complete."

        # Install Certbot and Nginx plugin
        if prompt_yes_no "Do you want to install Certbot for Nginx (for SSL certificates)?"; then
            echo "Installing Certbot and Nginx plugin..."
            if [[ "$OS" == "macos" ]]; then
                $INSTALL_CMD certbot certbot-nginx
            elif [[ "$OS" == "debian_ubuntu" ]]; then
                $INSTALL_CMD certbot python3-certbot-nginx
            elif [[ "$OS" == "rhel_centos" || "$OS" == "fedora" ]]; then
                # For RHEL/CentOS/Fedora, EPEL repo is usually needed for certbot
                if [[ "$OS" == "rhel_centos" ]] && ! $SUDO_CMD yum list installed epel-release > /dev/null 2>&1; then
                    echo "EPEL repository is not installed. Attempting to install EPEL..."
                    $SUDO_CMD yum install -y epel-release
                    $UPDATE_CMD # Update after adding new repo
                fi
                $INSTALL_CMD certbot python3-certbot-nginx # Or python-certbot-nginx depending on distro version
            elif [[ "$OS" == "arch" ]]; then
                $INSTALL_CMD certbot certbot-nginx
            else
                echo "Certbot installation for Nginx might require specific packages for $OS. Please check Certbot documentation."
            fi
            if command -v certbot >/dev/null 2>&1; then
                echo "Certbot installation complete. You can now use 'sudo certbot --nginx' to configure SSL."
            else
                echo "Certbot installation may have failed."
            fi
        fi
    fi

    # 3. Install PHP (prompt first and ask which php version)
    PHP_INSTALLED=false
    if prompt_yes_no "Do you want to install PHP?"; then
        read -p "Which PHP version do you want to install? (e.g., 7.4, 8.0, 8.1, 8.2, 8.3) [default: 8.1]: " PHP_VERSION
        PHP_VERSION=${PHP_VERSION:-8.1}
        echo "Attempting to install PHP $PHP_VERSION..."
        # PHP installation varies greatly. This is a generic attempt.
        # For Debian/Ubuntu, you might need Ondřej Surý's PPA: sudo add-apt-repository ppa:ondrej/php
        # For macOS with brew: brew install php@$PHP_VERSION
        if [[ "$OS" == "macos" ]]; then
            $INSTALL_CMD php@$PHP_VERSION
        elif [[ "$OS" == "debian_ubuntu" ]]; then
            # Add PPA for PHP if not already added (common practice)
            if ! grep -q "ondrej/php" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
                 echo "Adding Ondřej Surý's PPA for PHP..."
                 $SUDO_CMD apt-get install -y software-properties-common
                 $SUDO_CMD add-apt-repository ppa:ondrej/php -y
                 $UPDATE_CMD
            fi
            $INSTALL_CMD php$PHP_VERSION
        elif [[ "$OS" == "rhel_centos" || "$OS" == "fedora" ]]; then
            # RHEL/CentOS/Fedora might need EPEL/Remi repository
            echo "For RHEL/CentOS/Fedora, you might need to enable EPEL and Remi repositories first."
            echo "Attempting generic install: php$PHP_VERSION (might require specific package names like php${PHP_VERSION//.})"
            $INSTALL_CMD php # Or more specific like php81, php74 - this is a simplification
        else
            $INSTALL_CMD php # Generic attempt
        fi
        # Verify PHP installation (simple check)
        if command -v php >/dev/null 2>&1; then
            echo "PHP installation seems successful. Version: $(php -v | head -n 1)"
            PHP_INSTALLED=true

            # Install Composer
            if prompt_yes_no "Do you want to install Composer?"; then
                echo "Installing Composer..."
                EXPECTED_CHECKSUM="$(php -r 'copy("https://composer.github.io/installer.sig", "php://stdout");')"
                php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
                ACTUAL_CHECKSUM="$(php -r "echo hash_file('sha384', 'composer-setup.php');")"

                if [ "$EXPECTED_CHECKSUM" != "$ACTUAL_CHECKSUM" ]
                then
                    >&2 echo 'ERROR: Invalid installer checksum'
                    rm composer-setup.php
                    exit 1
                fi

                php composer-setup.php --install-dir=/usr/local/bin --filename=composer
                RESULT=$?
                rm composer-setup.php
                if [ $RESULT -eq 0 ] && command -v composer >/dev/null 2>&1; then
                    echo "Composer installed globally to /usr/local/bin/composer"
                    composer --version
                else
                    echo "Composer installation failed or it's not in PATH."
                    # Attempt to install with sudo if /usr/local/bin is not writable by current user
                    if [ $RESULT -ne 0 ] && [ ! -w /usr/local/bin ]; then
                        echo "Attempting to install Composer with sudo as /usr/local/bin might not be writable..."
                        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
                        $SUDO_CMD php composer-setup.php --install-dir=/usr/local/bin --filename=composer
                        RESULT_SUDO=$?
                        rm composer-setup.php
                        if [ $RESULT_SUDO -eq 0 ] && command -v composer >/dev/null 2>&1; then
                             echo "Composer installed globally to /usr/local/bin/composer with sudo."
                             composer --version
                        else
                            echo "Composer installation with sudo also failed."
                        fi
                    fi 
                fi
            fi
        else
            echo "PHP installation may have failed or PHP is not in PATH."
        fi
    fi

    # 4. If install php prompt to install php-fpm or not
    if [ "$PHP_INSTALLED" = true ]; then
        if prompt_yes_no "Do you want to install PHP-FPM?"; then
            echo "Installing PHP-FPM for PHP $PHP_VERSION..."
            if [[ "$OS" == "macos" ]]; then
                # Usually installed with php package itself or as php@version-fpm
                echo "PHP-FPM is typically included with php install on macOS or handled by the php formula."
            elif [[ "$OS" == "debian_ubuntu" ]]; then
                $INSTALL_CMD php$PHP_VERSION-fpm
            elif [[ "$OS" == "rhel_centos" || "$OS" == "fedora" ]]; then
                 $INSTALL_CMD php-fpm # Or more specific like php81-php-fpm
            else
                $INSTALL_CMD php-fpm # Generic attempt
            fi
            echo "PHP-FPM installation attempt complete."
        fi
    fi

    # 5. Make new user (prompt first and ask for user name other than "work") then add to sudoers group
    if prompt_yes_no "Do you want to create a new system user?"; then
        read -p "Enter username for the new user [default: work]: " NEW_USERNAME
        NEW_USERNAME=${NEW_USERNAME:-work}
        echo "Creating user '$NEW_USERNAME'..."
        if [[ "$OS" == "macos" ]]; then
            # macOS user creation is more complex, typically done via System Preferences
            # or dscl. This is a simplified placeholder.
            echo "On macOS, user creation is typically done via GUI or 'dscl'. Manual steps required."
            echo "Example: sudo dscl . -create /Users/$NEW_USERNAME"
            echo "Then set password, shell, home directory etc."
        else
            $SUDO_CMD useradd -m -s /bin/bash "$NEW_USERNAME"
            if [ $? -eq 0 ]; then
                echo "User '$NEW_USERNAME' created. Please set a password for the user manually using 'sudo passwd $NEW_USERNAME'."
                SUDO_GROUP="sudo"
                if [[ "$OS" == "rhel_centos" || "$OS" == "fedora" || "$OS" == "arch" ]]; then
                    SUDO_GROUP="wheel"
                fi
                echo "Adding user '$NEW_USERNAME' to '$SUDO_GROUP' group..."
                $SUDO_CMD usermod -aG "$SUDO_GROUP" "$NEW_USERNAME"
                echo "User '$NEW_USERNAME' added to '$SUDO_GROUP' group."
            else
                echo "Failed to create user '$NEW_USERNAME'."
            fi
        fi
    fi

    # 6. Install git (prompt first)
    GIT_INSTALLED=false
    if prompt_yes_no "Do you want to install Git?"; then
        echo "Installing Git..."
        $INSTALL_CMD git
        if command -v git >/dev/null 2>&1; then
            echo "Git installation complete."
            GIT_INSTALLED=true
        else
            echo "Git installation failed."
        fi
    fi

    # 7. If install git then make ssh public key, prompt for email
    SSH_KEY_GENERATED=false
    if [ "$GIT_INSTALLED" = true ]; then
        if prompt_yes_no "Do you want to generate an SSH key for Git?"; then
            read -p "Enter your email for the SSH key: " SSH_EMAIL
            if [ -z "$SSH_EMAIL" ]; then
                echo "Email cannot be empty. Skipping SSH key generation."
            else
                SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
                echo "Generating SSH key  Press Enter for no passphrase."
                ssh-keygen -t ed25519 -C "$SSH_EMAIL"
                if [ -f "${SSH_KEY_PATH}.pub" ]; then
                    echo "SSH key generated successfully."
                    SSH_KEY_GENERATED=true
                    PUBLIC_KEY_FILE="${SSH_KEY_PATH}.pub"
                else
                    echo "SSH key generation failed."
                fi
            fi
        fi
    fi

    # 8. Cat the created public key
    if [ "$SSH_KEY_GENERATED" = true ]; then
        echo "Your public SSH key ($PUBLIC_KEY_FILE):"
        cat "$PUBLIC_KEY_FILE"
        echo "\nAdd this public key to your Git hosting service (e.g., GitHub, GitLab)."
    fi

    echo "Script execution finished."
}

main