#!/usr/bin/bash
 
PROCESS=VBoxHeadless

ps_out=`ps -ef | grep $PROCESS | grep -v 'grep' | grep -v $0`
result=$(echo $ps_out | grep "$PROCESS")
if [[ "$result" != "" ]];then
    cd $p5 && vagrant halt
else
    cd $p5 && vagrant up
fi
