#!/bin/bash

# for nova user
usermod -s /bin/bash nova
su nova
ssh-keygen -t rsa

cat /var/lib/nova/.ssh/id_rsa.pub  >> /var/lib/nova/.ssh/authorized_keys
echo 'StrictHostKeyChecking no' >> /var/lib/nova/.ssh/config

local_hostname=`hostname`

for x in `seq 1 12`
do
  remote_hostname="hostname-$x"
  if [ $local_hostname != $remote_hostname ]
  then
    echo "[$remote_hostname] Copying /var/lib/nova/.ssh/id_rsa.pub  >> /var/lib/nova/.ssh/authorized_keys ..."
    cat /var/lib/nova/.ssh/id_rsa.pub | ssh root@$remote_hostname "cat >>  /var/lib/nova/.ssh/authorized_keys && chown nova:nova /var/lib/nova/.ssh/*"
  fi
done   
                                                                                       
