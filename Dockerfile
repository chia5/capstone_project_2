FROM ubuntu:18
RUN apt update && apt-get install apache2 -y
COPY . /var/www/html
ENTRYPOINT apachectl -D FOREGROUND
EXPOSE 80
