FROM ubuntu

ARG TZ=Europe/Madrid
ARG PROYECTO=EMDE
ARG USUARIO=mohamed
ARG PASSWD=Mohamed1.*
ARG IP=5.189.148.45

ENV PROYECTO=${PROYECTO}
ENV USUARIO=${USUARIO}
ENV PASSWD=${PASSWD}
ENV TZ=${TZ}
ENV IP=${IP}
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


WORKDIR /usr/local/bin
RUN mkdir ./docker
COPY ./start.sh ./docker
RUN chmod o+x ./docker/start.sh
WORKDIR /root
COPY ./id_rsa.pub /root

ENTRYPOINT ["/usr/local/bin/docker/start.sh"]
