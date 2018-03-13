FROM alpine:edge

RUN apk update \
    && apk add nginx \
    && adduser -D -u 1000 -g 'www' www \
    && mkdir /www \
    && chown -R www:www /var/lib/nginx \
    && chown -R www:www /www \
    && rm -rf /etc/nginx/nginx.conf

ENV PHP_FPM_USER="www"
ENV PHP_FPM_GROUP="www"
ENV PHP_FPM_LISTEN_MODE="0660"
ENV PHP_MEMORY_LIMIT="512M"
ENV PHP_MAX_UPLOAD="50M"
ENV PHP_MAX_FILE_UPLOAD="200"
ENV PHP_MAX_POST="100M"
ENV PHP_DISPLAY_ERRORS="On"
ENV PHP_DISPLAY_STARTUP_ERRORS="On"
ENV PHP_ERROR_REPORTING="E_COMPILE_ERROR\|E_RECOVERABLE_ERROR\|E_ERROR\|E_CORE_ERROR"
ENV PHP_CGI_FIX_PATHINFO=0
ENV TIMEZONE="Africa/Johannesburg"
ENV CUSTOM_HOSTNAME="www.rgdraughting.con"

RUN apk add curl ssmtp tzdata \
    php5-fpm php5-mcrypt php5-soap php5-openssl php5-gmp \
    php5-pdo_odbc php5-json php5-dom php5-pdo php5-zip \
    php5-mysql php5-mysqli php5-sqlite3 php5-pdo_pgsql \
    php5-bcmath php5-gd php5-odbc php5-pdo_mysql \
    php5-pdo_sqlite php5-gettext php5-xmlreader php5-xmlrpc \
    php5-bz2 php5-iconv php5-pdo_dblib php5-curl php5-ctype

RUN sed -i "s|;listen.owner\s*=\s*nobody|listen.owner = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf \
    && sed -i "s|;listen.group\s*=\s*nobody|listen.group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf \
    && sed -i "s|;listen.mode\s*=\s*0660|listen.mode = ${PHP_FPM_LISTEN_MODE}|g" /etc/php5/php-fpm.conf \
    && sed -i "s|user\s*=\s*nobody|user = ${PHP_FPM_USER}|g" /etc/php5/php-fpm.conf \
    && sed -i "s|group\s*=\s*nobody|group = ${PHP_FPM_GROUP}|g" /etc/php5/php-fpm.conf \
    && sed -i "s|;log_level\s*=\s*notice|log_level = notice|g" /etc/php5/php-fpm.conf \
    && sed -i 's/include\ \=\ \/etc\/php5\/fpm.d\/\*.conf/\;include\ \=\ \/etc\/php5\/fpm.d\/\*.conf/g' /etc/php5/php-fpm.conf

RUN sed -i "s|display_errors\s*=\s*Off|display_errors = ${PHP_DISPLAY_ERRORS}|i" /etc/php5/php.ini \
    && sed -i "s|display_startup_errors\s*=\s*Off|display_startup_errors = ${PHP_DISPLAY_STARTUP_ERRORS}|i" /etc/php5/php.ini \
    && sed -i "s|error_reporting\s*=\s*E_ALL & ~E_DEPRECATED & ~E_STRICT|error_reporting = ${PHP_ERROR_REPORTING}|i" /etc/php5/php.ini \
    && sed -i "s|;*memory_limit =.*|memory_limit = ${PHP_MEMORY_LIMIT}|i" /etc/php5/php.ini \
    && sed -i "s|;*upload_max_filesize =.*|upload_max_filesize = ${PHP_MAX_UPLOAD}|i" /etc/php5/php.ini \
    && sed -i "s|;*max_file_uploads =.*|max_file_uploads = ${PHP_MAX_FILE_UPLOAD}|i" /etc/php5/php.ini \
    && sed -i "s|;*post_max_size =.*|post_max_size = ${PHP_MAX_POST}|i" /etc/php5/php.ini \
    && sed -i "s|;*cgi.fix_pathinfo=.*|cgi.fix_pathinfo= ${PHP_CGI_FIX_PATHINFO}|i" /etc/php5/php.ini \
    && sed -i 's/SMTP\ =\ localhost/SMTP\ =\ mail.unit1-technologies.com/g' /etc/php5/php.ini \
    && sed -i 's/;sendmail_path\ =/sendmail_path\ =\ \/usr\/sbin\/sendmail\ -t/g' /etc/php5/php.ini \
    && echo 'sendmail_path = "/usr/sbin/ssmtp -t "' > /etc/php5/conf.d/mail.ini \
    && echo "hostname=${CUSTOM_HOSTNAME}" >> /etc/ssmtp/ssmtp.conf \
    && sed -i 's/mailhub=mail/mailhub=mail.unit1-technologies.com\:25/g' /etc/ssmtp/ssmtp.conf

RUN rm -rf /etc/localtime \
    && ln -s /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo "${TIMEZONE}" > /etc/timezone \
    && sed -i "s|;*date.timezone =.*|date.timezone = ${TIMEZONE}|i" /etc/php5/php.ini \
    && echo "127.0.0.1 ${CUSTOM_HOSTNAME}" >> /etc/hosts

COPY nginx.conf /etc/nginx/nginx.conf
ADD  html /www/
COPY start_nginx.sh /start_nginx.sh
COPY start_php-fpm5.sh /start_php-fpm5.sh
COPY wrapper.sh /wrapper.sh

RUN chmod +x /start_nginx.sh /start_php-fpm5.sh /wrapper.sh

CMD ["/wrapper.sh"]

