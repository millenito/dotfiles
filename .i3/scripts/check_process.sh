#!/usr/bin/bash
 
PROCESS=VBox

ps_out=`ps -ef | grep $PROCESS | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$PROCESS")
if [[ "$result" != "" ]];then
    echo "Running"
else
    echo "Not Running"
fi
