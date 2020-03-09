FROM ubuntu:18.04
RUN apt update && apt upgrade
RUN apt install -y \
    wget \
    unzip
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
&& unzip sdk-tools-linux-3859397.zip && rm sdk-tools-linux-3859397.zip
run ls
