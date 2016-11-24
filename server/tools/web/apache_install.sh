#TODO httpd.confのコメントアウトと空行はどうするか
#`echo grep -v -e '^\s*#' -e '\s*$'`
#!/bin/sh

HOSTNAME=`hostname`

yum -y install httpd httpd-manual
yum -y install --enablerepo=remi,remi-php70 php php-devel php-opcache php-mbstring php-mcrypt php-pdo php-gd php-mysqlnd php-pecl-xdebug php-fpm php-xml

mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
sed -i -e "s/^ServerName.*$/ServerName ${HOSTNAME}/g" '/root/httpd.conf'
mv /root/httpd.conf /etc/httpd/conf/
chcon --reference=/etc/httpd/conf/httpd.conf.bak /etc/httpd/conf/httpd.conf
#chcon -u system_u -t httpd_config_t /etc/httpd/conf/httpd.conf

service httpd start
chkconfig httpd on

IPTABLEFILE='/etc/sysconfig/iptables'
HTTPINFO='-A INPUT -p tcp -m tcp --dport http -j ACCEPT'

sed -i -e "/22/a ${HTTPINFO}" ${IPTABLEFILE}
service iptables restart

reboot

