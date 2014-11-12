#!/bin/bash

HOSTS="10.0.1.64 10.0.1.81 10.0.1.82 10.0.1.83 10.0.1.84 10.0.1.85"

for HOST in ${HOSTS}; do
    ssh -o StrictHostKeyChecking=no -t -i /home/ec2-user/richard-im-aws.pem ec2-user@${HOST} "sudo mv krb5.conf /etc/"
done