#!bin/bash
#a=`ps auxw | grep ntpd | grep -v grep`


if [[ -z $(pgrep ntp) ]];
then
echo "NOTICE: ntp is not running" >> /var/mail/root
service ntp start
fi;
d=`diff -u0 /etc/ntp.conf /etc/ntp.conf.bak`
# diff -u   <(grep -v '^\s*(#|$)' /etc/ntp.conf) <(grep -v '^\s*(#|$)' /etc/ntp.conf.bak)

diff -u0 /etc/ntp.conf /etc/ntp.conf.bak
if [[ "$?" -eq "1" ]];
then
echo "NOTICE: /etc/ntp.conf was changed. Calculated diff:" >> /var/mail/root
echo "$d" >> /var/mail/root
cp /etc/ntp.conf.bak /etc/ntp.conf
service ntp restart
fi;

