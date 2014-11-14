sudo yum update ca-certificates
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
# sudo vi /etc/yum.repos.d/epel.repo
 
curl -sL https://archive.gazzang.com/deployment/zncrypt-install.sh | sudo bash

# then register the zncrypt client with ztrustee server
sudo zncrypt register --skip-ssl-check -s ip-10-0-1-55.ec2.internal -o its-sf-frb-gov --auth=revWGYiWf/nUs6RqN/gfOw==

# master passphrase 15 characters
# using file encryption, block requires reformat of the block device

## Set up acls - non -kerberos
#sudo -s
# grab pid of datanode
# PIDS="$(ps -ef | grep -i [d]atanode | awk '{ print $2}')"

# Create profile
# for pid in ${PIDS[@]}; do zncrypt-profile --pid=$pid > /tmp/znc_profile_$pid; done

# This may fail so run as needed
#for profile in "$(ls /tmp/znc_profile_*)"; do zncrypt acl --add -r "ALLOW @hadoop * $(grep "cmdline" $profile | tr [=\"=],[=:=] " " | awk '{ print $2 }' | xargs readlink -f)" --profile-file=$profile; done

# OR #RUN AS ONE LINE #
# sudo -s  # Capture PID(s) of datanode process. Replace [d]atanode below with whatever you want to capture ([h]adoop, etc.) PIDS="$(ps -ef | grep -i [d]atanode | awk '{ print $2}')"   # Generate profile(s), where we use a for loop just in case we get more than one result for pid in ${PIDS[@]}; do zncrypt-profile --pid=$pid > /tmp/znc_profile_$pid; done   # Attach the profiles to the ACL's for profile in "$(ls /tmp/znc_profile_*)"; do zncrypt acl --add -r "ALLOW @hadoop * $(grep "cmdline" $profile | tr [=\"=],[=:=] " " | awk '{ print $2 }' | xargs readlink -f)" --profile-file=$profile; done   # If you added ACLs prior to attaching profiles, make sure you remove them once completed. exit


#### performed on 10.0.1.136 all below - verify encryption?
# script this stuff for all hosts?
# Set up with kerberos
sudo zncrypt acl --add --rule="ALLOW @hdfs * *"

# Prepare directories to mount/house the encrypted files on each disk - data0/1
sudo mkdir -p /data0/zncrypt/storage
sudo mkdir -p /data0/zncrypt/mount
sudo zncrypt-prepare /data0/zncrypt/storage /data0/zncrypt/mount

sudo mkdir -p /data1/zncrypt/storage
sudo mkdir -p /data1/zncrypt/mount
sudo zncrypt-prepare /data1/zncrypt/storage /data1/zncrypt/mount

# Encrypt dfs dir - note not to cyclically encrypt a directory target too high to resolve
# e.g. cant encrypt source data in a target within the same folder higher than the source
# no dice to do /data0 /data0/zncrypt/mount since the symlink would by pass other subdirs of
# /data0...
sudo zncrypt-move encrypt @hadoop /data0/dfs/dn/ /data0/zncrypt/mount/
sudo zncrypt-move encrypt @hadoop /data1/dfs/dn/ /data1/zncrypt/mount/