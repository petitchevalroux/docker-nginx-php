FROM debian:wheezy
MAINTAINER Patrick Poulain <docker@m41l.me>
RUN apt-get update
RUN apt-get -y install wget
RUN cd /tmp
RUN wget http://www.dotdeb.org/dotdeb.gpg
RUN apt-key add dotdeb.gpg
RUN apt-get -y purge wget
RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
RUN apt-get update && apt-get install -y nginx-extras
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www && \
    echo "Hello World !" > /var/www/index.html && \
    chown -R www-data:www-data /var/www
RUN apt-get -y autoremove
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
EXPOSE 80
CMD ["nginx"]
COPY ./includes /etc/nginx/includes
ENV SERVER_NAME localhost