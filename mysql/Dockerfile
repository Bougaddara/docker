FROM ubuntu
RUN apt update && apt install -yq --no-install-recommends 

EXPOSE 22
EXPOSE 3306 33060
#indicamos el timezone
ARG TZ=Europe/Madrid
ENV TZ=${TZ}


ARG USUARIO=mohamed
ARG PASSWD=Mohamed1.*

ENV USUARIO=${USUARIO}
ENV PASSWD=${PASSWD}

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

USER root
RUN apt install -y mysql-server mysql-common mysql-client
COPY ./id_rsa.pub /root
COPY ./start.sh /root
COPY ./mysql.exp /root
COPY ./emde.sql /root
RUN chmod o+x /root/mysql.exp


RUN chmod o+x /root/start.sh
ENTRYPOINT [ "/root/start.sh" ]
