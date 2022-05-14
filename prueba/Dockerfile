FROM ubuntu

ARG TZ=Europe/Madrid
ARG PROYECTO=EMDE
ARG USUARIO=mohamed
ARG PASSWD=Mohamed1.*

ENV PROYECTO=${PROYECTO}
ENV USUARIO=${USUARIO}
ENV PASSWD=${PASSWD}
ENV TZ=${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt update && apt install -yq --no-install-recommends \
    apt-utils \
    wget \ 
    curl \ 
    git \
    nano \ 
    tree \
    net-tools \ 
    iputils-ping \
    sudo \ 
    openssh-server \ 
    openssh-client \
    unzip \
    dos2unix \ 
    expect \
    python3


RUN apt-get update && apt-get install -y php \
    php-cli \
    php-fpm \
    php-json \
    php-common \
    php-mysql \
    php-zip \
    php-gd \
    php-mbstring \
    php-curl \
    php-xml \
    php-pear \ 
    php-bcmath \
    apache2 

RUN apt update && apt install -yq --no-install-recommends \
    mysql-client
EXPOSE 22
EXPOSE 80

RUN apt-get install ca-certificates
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer



COPY ./phpmyadmin.exp /root
RUN chmod o+x /root/phpmyadmin.exp

WORKDIR /usr/local/bin
RUN mkdir ./docker
COPY ./start.sh ./docker
RUN chmod o+x ./docker/start.sh
WORKDIR /root
COPY ./id_rsa.pub /root

ENTRYPOINT ["/usr/local/bin/docker/start.sh"]
