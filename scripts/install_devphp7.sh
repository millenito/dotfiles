#!/usr/bin/bash
 
# PROCESS=VBoxHeadless
#
# ps_out=`ps -ef | grep $PROCESS | grep -v 'grep' | grep -v $0`
# result=$(echo $ps_out | grep "$PROCESS")
# if [[ "$result" != "" ]];then
#     cd $P5 && vagrant halt
#     # cd $P7 && vagrant halt
# else
#     cd $P5 && vagrant up
#     # cd $P7 && vagrant up
# fi

docker --version | grep "Docker version"
if [ $? -eq 0 ]
then
	echo "docker existing"
else
	echo "install docker"
fi
