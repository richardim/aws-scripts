#!/bin/bash

HOSTS="10.0.2.48 10.0.1.166 10.0.1.167 10.0.1.168 10.0.1.169 10.0.1.170"

for HOST in ${HOSTS}; do
    scp -i /home/ec2-user/richard-im-aws.pem /etc/krb5.conf ec2-user@${HOST}:
done