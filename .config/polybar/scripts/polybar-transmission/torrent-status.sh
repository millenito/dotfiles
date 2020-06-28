#!/usr/bin/env sh

if pgrep -x transmission-da > /dev/null
then
    DOWNLOADING=$(transmission-remote -l | grep -e "Downloading" -e "Up & Down" | awk '{print " " $7 " KB/s  ", " "  $8 " KB/s "}')

    # DOWNLOADING=$(transmission-remote -l | grep "Up & Down")

    ICONS=$(transmission-remote -l | grep % |
        sed " # This first sed command is to ensure a desirable order with sort
            s/.*Stopped.*/A/g;
            s/.*Seeding.*/Z/g;
            s/.*100%.*/N/g;
            s/.*Idle.*/B/g;
            s/.*Uploading.*/L/g;
            s/.*%.*/M/g" |
            sort -h | uniq -c | sed " # Now we replace the standin letters with icons.
                s/A//g;
                s/B//g;
                s/L//g;
                s/M//g;
                s/N//g;
                s/Z//g" | awk '{print $2, " " $1}' | sed -e "s/ $//g" -e :a -e '$!N; s/\n/  /; ta')

    echo "${DOWNLOADING} ${ICONS}"
else
    echo ""
fi
