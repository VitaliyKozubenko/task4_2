#!bin/bash
#установил
apt-get install ntp

#заменил и удалил
sed -i 's/0.ubuntu.pool.ntp.org/ua.pool.ntp.org/g' /etc/ntp.conf
sed -i '/.ubuntu.pool.ntp.org/d' /etc/ntp.conf

cp /etc/ntp.conf /etc/ntp.conf.bak

#перезагрузил
service ntp restart
#a=` grep "$(pwd)/ntp_verify.sh" /etc/crontab`
if [[ -z $(grep "$(pwd)/ntp_verify.sh" /etc/crontab) ]];
then
echo "* * * * *   root    bash $(pwd)/ntp_verify.sh" >> /etc/crontab
fi;

