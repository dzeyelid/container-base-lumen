#!/bin/sh

ln -s ${WORK_DIR}/.env.${APP_ENV} ${WORK_DIR}/.env

/etc/init.d/php7.0-fpm start
nginx -g "daemon off;"