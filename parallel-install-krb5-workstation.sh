#!/bin/bash

HOSTS="10.0.1.185 10.0.1.166 10.0.1.167 10.0.1.168 10.0.1.169 10.0.1.170"

for HOST in ${HOSTS}; do
    ssh -t -i /home/ec2-user/richard-im-aws.pem ec2-user@${HOST} "sudo yum install krb5-workstation"
done