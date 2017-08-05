#!/bin/sh

COMPOSER_INST_DIR=/usr/local/bin
COMPOSER_FILENAME=composer

install_composer() {
    echo 'Installing composer...'

    current_dir=$(pwd)
    cd /tmp

    # refs: https://getcomposer.org/doc/faqs/how-to-install-composer-programmatically.md

    local EXPECTED_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig)
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    local ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');")

    if [ "$EXPECTED_SIGNATURE" != "$ACTUAL_SIGNATURE" ]
    then
        >&2 echo 'ERROR: Invalid installer signature'
        rm composer-setup.php
        exit 1
    fi

    php composer-setup.php --quiet --install-dir=${COMPOSER_INST_DIR} --filename=${COMPOSER_FILENAME}
    local RESULT=$?
    rm composer-setup.php

    cd ${current_dir}

    echo 'Completed installing composer.'

    return ${RESULT}
}

install_laravel_lumen() {
    composer global require "laravel/lumen-installer"
}

# Install Composer
if [ ! -e "${COMPOSER_INST_DIR}/${COMPOSER_FILENAME}" ]; then
    install_composer
    install_laravel_lumen
fi
