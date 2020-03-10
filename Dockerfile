FROM ubuntu:18.04

# Update and Upgrade ubuntu
RUN apt update && apt upgrade

#Install Required Packages
RUN apt install -y \
    wget \
    unzip \
    openjdk-8-jdk \
    git  \
    zip \
    bash \
    curl \
    xz-utils
    
# Downloading and setting up Android-sdk-tools
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
&& unzip sdk-tools-linux-3859397.zip && rm sdk-tools-linux-3859397.zip
RUN mkdir Android
RUN mv tools/ Android/
RUN mv Android/ /usr/lib

#android home
ENV  ANDROID_HOME=/usr/lib/Android 
ENV  PATH=$ANDROID_HOME/tools:$PATH  
ENV  PATH=$ANDROID_HOME/tools/bin:$PATH 
ENV  PATH=$ANDROID_HOME/platform-tools:$PATH
    
#android sdk root
ENV ANDROID_SDK_ROOT=/usr/lib/Android 
ENV PATH=$ANDROID_SDK_ROOT:$PATH
    
# Cloning flutter and setting environment
RUN git clone https://github.com/flutter/flutter.git -b stable \
    && mv flutter/ /usr/lib 
    
ENV FLUTTER_HOME=/usr/lib/flutter 
ENV PATH=$FLUTTER_HOME/bin:$PATH
RUN cd usr/lib/ && ls
    
# Downloading gradle
RUN wget https://services.gradle.org/distributions/gradle-6.2.2-bin.zip \
    && unzip gradle-6.2.2-bin.zip \
    && mkdir gradle && mv gradle-6.2.2/ gradle/  \
    && mv gradle/ /opt/  \
    && rm gradle-6.2.2-bin.zip

# Setting Gradle Environment
ENV GRADLE_HOME=/opt/gradle/gradle-6.2.2   
ENV PATH=$GRADLE_HOME/bin:$PATH

RUN . ~/.profile 

# Setting Android-Environment
RUN sdkmanager -y "system-images;android-29;google_apis;x86_64" \
   &&  "platforms;android-29"  \
   &&  "platform-tools"  \
   &&  "patcher;v4"  \
   &&  "emulator"    \
   &&  "build-tools;29.0.2" 
   
#RUN sdkmanager --licenses -y


RUN flutter config --android-sdk /usr/lib/Android


