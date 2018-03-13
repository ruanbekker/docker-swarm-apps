#!/bin/sh

# setting custom configs:
sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf
sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf
sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php5/php-fpm.conf 
sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf 
sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf 
sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php5/php-fpm.conf 
sed -i 's/include\ \=\ \/etc\/php5\/fpm.d\/\*.conf/\;include\ \=\ \/etc\/php5\/fpm.d\/\*.conf/g' /etc/php5/php-fpm.conf

/start_php-fpm5.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "php-fpm5 Failed: $status"
  exit $status
  else echo "Starting PHP-FPM: OK"
fi

sleep 2

/start_nginx.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Nginx Failed: $status"
  exit $status
  else echo "Starting Nginx: OK"
fi

sleep 2

while /bin/true; do
  ps aux | grep 'php-fpm: master process' | grep -q -v grep
  PHP_FPM_STATUS=$?
  echo "Checking PHP-FPM, Status Code: $PHP_FPM_STATUS"
  sleep 2

  ps aux | grep 'nginx: master process' | grep -q -v grep
  NGINX_STATUS=$?
  echo "Checking NGINX, Status Code: $NGINX_STATUS"
  sleep 2

  if [ $PHP_FPM_STATUS -ne 0 ];
    then
      echo "$(date +%F_%T) FATAL: PHP-FPM Raised a Status Code of $PHP_FPM_STATUS and exited"
      exit -1

   elif [ $NGINX_STATUS -ne 0 ];
     then
       echo "$(date +%F_%T) FATAL: NGINX Raised a Status Code of $NGINX_STATUS and exited"
       exit -1

   else
     sleep 2
        echo "$(date +%F_%T) - HealtCheck: NGINX and PHP-FPM: OK"
  fi
  sleep 60
done

