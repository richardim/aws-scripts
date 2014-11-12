#!/bin/bash

HOSTS="10.0.1.64 10.0.1.81 10.0.1.82 10.0.1.83 10.0.1.84 10.0.1.85"
USERS="rim"
I=1001
for HOST in ${HOSTS}; do
  for USER in ${USERS}; do
    ssh -t -i /home/ec2-user/richard-im-aws.pem ec2-user@${HOST} "sudo useradd -u $I ${USER}"
    I=$[$I + 1]
  done
  I=1001
done