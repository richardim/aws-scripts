#!/bin/bash

HOSTS="10.0.1.185 10.0.1.166 10.0.1.167 10.0.1.168 10.0.1.169 10.0.1.170"
USERS="rim"
I=1001
for HOST in ${HOSTS}; do
  for USER in ${USERS}; do
    ssh -t -i /home/ec2-user/richard-im-aws.pem ec2-user@${HOST} "sudo useradd -u $I ${USER}"
    I=$[$I + 1]
  done
  I=1001
done