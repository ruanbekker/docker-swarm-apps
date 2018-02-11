FROM ulsmith/alpine-apache-php7
ADD limesurvey.tar.gz /app/public
RUN mv /app/public/limesurvey/* /app/public/ && rm -rf /app/public/limesurvey
RUN chown -R apache:apache /app
