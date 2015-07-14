#!/bin/bash
#### dla nova usera

usermod -s /bin/bash nova
su nova
ssh-keygen

cat /var/lib/nova/.ssh/id_rsa.pub  >> /var/lib/nova/.ssh/authorized_keys
echo 'StrictHostKeyChecking no' >> /var/lib/nova/.ssh/config
echo "Copying /var/lib/nova/.ssh/id_rsa.pub  >> /var/lib/nova/.ssh/authorized_keys ..."

for x in `seq 1 12`
do
  hostname="cisco-cn-$x"
  scp /var/lib/nova/.ssh/id_rsa.pub root@$hostname:/var/lib/nova/.ssh/authorized_keys
  ssh root@$hostname | chown nova:nova /var/lib/nova/.ssh/*
done   
                                                                                       
