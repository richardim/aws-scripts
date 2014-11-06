#!/bin/bash

HOSTS="server1 server2"

for HOST in ${HOSTS}; do
    scp -i <key> <file> ec2-user@${HOST}:
done