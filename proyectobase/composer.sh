#!/bin/bash
set -echo


alias get Composer=php -r "copy('http://getcomposer.org/install', 'composer-setup.php')"
alias installComposer= `php composer-setup.php --install-dir=/usr/local/bin --filename=composer`

getComposer
if [ -f composer-setup.php];
then 
    if [ -f composer-setup.php ];
    then
        installComposer
    fi
fi