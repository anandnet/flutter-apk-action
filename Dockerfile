from ubuntu:18.04
run apt-get update
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
&& unzip sdk-tools-linux-3859397.zip && rm sdk-tools-linux-3859397.zip
run ls
