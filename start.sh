#!/bin/bash 
sudo service ssh start 

if hostname | grep -q 'master'
then 
    hdfs --daemon start journalnode 
    ID=$(hostname | tail -c 2)

    echo $ID > /usr/local/zookeeper/data/myid 
    zkServer.sh start
    if [ $ID -eq 1 ]
    then
        hdfs namenode -format
        hdfs zkfc -formatZK
    else
        sleep 30
        hdfs namenode -bootstrapStandby    
    fi
    hdfs --daemon start namenode         
fi      



sleep infinity
# This script starts the SSH service and keeps the container running indefinitely.
# It is useful for debugging and testing purposes.