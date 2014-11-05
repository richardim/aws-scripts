#!/bin/bash

HOSTS="server1 server2"

for HOST in ${HOSTS}; do
    ssh -t -i <key> <user>@${HOST} "<command>"
done