sudo pacman -Syu && sudo pacman -Sy apache vim bash-completion
echo "open your editor and change line 231 in /etc/httpd/conf/httpd.conf to your domain/ip address"
sudo systemctl enable --now httpd && sudo systemctl status httpd
sudo pacman -Sy php-{cgi,gd,pgsql,fpm,apache}
echo "Uncomment lines 931 & 899, extension=pdo_mysql &
extension=mysqli, in /etc/php/php.ini"
sudo pacman -S libmariadbclient mariadb mariadb-clients
sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql && sudo systemctl enable --now mysqld.service
sudo mysql_secure_installation && mysql -u root -p
curl -O https://wordpress.org/latest.tar.gz && tar xvf latest.tar.gz && sudo mv wordpress /srv/http/mysite
sudo mv /srv/http/mysite/wp-config-sample.php  /srv/http/mysite/wp-config.php
echo "open /srv/http/mysite/wp-config.php in your editor and change the following:"
echo "line 23- define( 'DB_NAME', 'wordpress' );"
echo "line 26- define( 'DB_USER', 'wordpress' );"
echo "line 29- define( 'DB_PASSWORD', 'StrongPassword' );"
sudo chown -R root:http /srv/http/mysite
echo "edit /etc/httpd/conf/extra/httpd-vhosts.conf to include the following: "
echo "ServerAdmin VALID_EMAIL_ACCOUNT"
echo "DocumentRoot '/srv/http/mysite'"
echo "ServerAlias YOUR_WORDPRESS_DOMAIN"
echo "ErrorLog '/var/log/httpd/YOUR_WORDPRESS_DOMAIN-error_log"
echo "CustomLog '/var/log/httpd/YOUR_WORDPRESS_DOMAIN-access_log"
echo "Open /etc/httpd/conf/httpd.conf then comment '#LoadModule mpm_event_module modules/mod_mpm_event.so' on line 66"
echo "then uncomment line 67 'LoadModule mpm_prefork_module modules/mod_mpm_prefork.so'"
echo "and uncomment line 514 'Include conf.extra.httpd-vhosts.conf"
echo "Next add these lines to /etc/httpd/conf/httpd.conf at the emd of LoadModule list: ~line 190"
echo "LoadModule php_module modules/libphp.so"
echo "AddHandler php-script .php"
echo " Add Include conf/extra/php_module.conf at the end of the Include list"
