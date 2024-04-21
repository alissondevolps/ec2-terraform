#!/bin/bash
apt-get update && apt-get install -yq software-properties-common \
    build-essential \
    apt-utils \
    dialog \
    iputils-ping \
    wget \
    curl \
    git \
    locales \
    ssh \
    zip \
    unzip \
    sudo \
    net-tools \
    nginx
service nginx start