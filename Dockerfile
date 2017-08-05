FROM ubuntu:16.04

ENV WORK_DIR /var/www/html

RUN apt-get update -y

RUN apt-get install -y \
    nginx \
    php7.0 \
    php7.0-fpm \
    php7.0-pgsql \
    php7.0-mbstring \
    php-xml

# for development
RUN apt-get install -y \
    php-xdebug \
    wget \
    git \
    zip \
    php7.0-zip

# for development
ADD ./setup-dev.sh /usr/local/setup-dev.sh
RUN sh /usr/local/setup-dev.sh
ENV PATH "/root/.composer/vendor/bin:${PATH}"

ADD ./run.sh /usr/local/run.sh

WORKDIR ${WORK_DIR}

CMD ["sh", "/usr/local/run.sh"]