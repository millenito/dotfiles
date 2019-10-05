#!/bin/bash

# Hide polybar system tray
hideIt.sh --name '^Polybar tray window$' --region 0x1080+10+-40

# Restart i3
i3-msg restart
