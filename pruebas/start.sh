#!/bin/bash
#set -e

new_user(){
    useradd -rm -d /home/"${USUARIO}" -s /bin/bash "${USUARIO}"
    echo "${USUARIO}:${PASSWD}" | chpasswd
}

config_Sudoers(){
    echo "${USUARIO} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
}

config_ssh() {
    sed -i 's/#Port 22/Port 22/' /etc/ssh/sshd_config
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    if [ ! -d /home/${USUARIO}/.ssh ]
    then
        mkdir /home/${USUARIO}/.ssh
        cat /root/id_rsa.pub >> /home/${USUARIO}/.ssh/authorized_keys
    fi
    /etc/init.d/ssh start
}


config_apache(){
    source /etc/apache2/envvars
    sed -i '172 s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
    sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/html\/api'${PROYECTO}'\/public/' /etc/apache2/sites-available/000-default.conf

    chown -R www-data:www-data /var/www/html/api${PROYECTO}
}

config_vhost(){
    cd /etc/apache2/sites-available
    
    touch api${PROYECTO}.conf
    echo "<VirtualHost *:80>" > api${PROYECTO}.conf
    echo "DocumentRoot /var/www/html/api${PROYECTO}/public" >> api${PROYECTO}.conf
    echo "ServerName api${PROYECTO}" >> api${PROYECTO}.conf
    echo "<Directory /var/www/html/api${PROYECTO}/public>" >> api${PROYECTO}.conf
    echo "    AllowOverride All" >> api${PROYECTO}.conf
    echo "    Require all granted" >> api${PROYECTO}.conf
    echo "</Directory>" >> api${PROYECTO}.conf
    #echo "ErrorLog ${APACHE_LOG_DIR}/error.log" >> api${PROYECTO}.conf
    #echo "CustomLog ${APACHE_LOG_DIR}/acces.log combined" >> api${PROYECTO}.conf
    echo "</VirtualHost>" >> api${PROYECTO}.conf
    a2ensite api${PROYECTO}.conf
    service apache2 reload
}





config_git(){
    cd /var/www/html
    if [ ! -d  /var/www/html/.git/ ];
    then
        echo "no existe .git"
        sudo git init
        sudo git remote add origin https://github.com/Bougaddara/proyectolaravel.git
        sudo git checkout -b master
    fi
       sudo git reset --hard 
       sudo git pull origin master
       
	   cd api${PROYECTO}

       sudo composer install
}
config_laravel(){

    cd /var/www/html
    #composer create-project laravel/laravel api${PROYECTO}
    #export COMPOSER_HOME="$HOME/.config/composer";
    
    cd api${PROYECTO}
    #cp .env.example .env

    sed -i "s/APP_URL=http:\/\/localhost/DB_HOST=5.189.148.45/" .env
    sed -i "s/DB_HOST=127.0.0.1/DB_HOST=5.189.148.45/g" .env
    #sed -i "s/DB_USERNAME=root/DB_USERNAME=${USUARIO}/g" .env
    #sed -i "s/DB_DATABASE=laravel/DB_DATABASE=emde/g" .env

    cd /etc/apache2/mods-enabled
    a2enmod rewrite
    service apache2 reload
}


composer(){

    export COMPOSER_HOME="$HOME/.config/composer";
}


main() {

    new_user
    config_Sudoers
    config_ssh
    composer
    config_git
    config_vhost
    #config_phpmyadmin
    config_apache
    config_laravel
    
}

main
/usr/sbin/apache2 -DFOREGROUND
#tail -f /dev/null
