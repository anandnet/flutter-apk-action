FROM ubuntu:18.04

# Update and Upgrade ubuntu
RUN apt update && apt upgrade

#Install Required Packages
RUN apt install -y \
    wget \
    unzip \
    openjdk-8-jdk \
    git
    
# Downloading and setting up Android-sdk-tools
RUN wget https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip \
&& unzip sdk-tools-linux-3859397.zip && rm sdk-tools-linux-3859397.zip
RUN mkdir Android
RUN mv tools/ Android/
RUN mv Android/ /usr/lib

#android home
RUN export ANDROID_HOME=/usr/lib/Android && \
    export PATH=$ANDROID_HOME/tools:$PATH   && \
    export PATH=$ANDROID_HOME/tools/bin:$PATH && \
    export PATH=$ANDROID_HOME/platform-tools:$PATH
    
#android sdk root
RUN export ANDROID_SDK_ROOT=/usr/lib/Android && \
    export PATH=$ANDROID_SDK_ROOT:$PATH
    
# Cloning flutter and setting environment
RUN git clone https://github.com/flutter/flutter.git -b stable \
    && mv flutter/ /usr/lib 
    
RUN export FLUTTER_HOME=/usr/lib/flutter \
    && export PATH=$FLUTTER_HOME/bin:$PATH
    
# Downloading gradle
RUN wget https://services.gradle.org/distributions/gradle-6.2.2-bin.zip \
    && unzip gradle-6.2.2-bin.zip \
    && mkdir gradle && mv gradle-6.2.2/ gradle/  \
    && mv gradle/ opt/  \
    && rm gradle-6.2.2-bin.zip

# Setting Gradle Environment
RUN export GRADLE_HOME=/opt/gradle/gradle-6.2.2   \
    && export PATH=$GRADLE_HOME/bin:$PATH

RUN export PATH="/path/to/dir:$PATH" \
    && source ~/.bashrc \
    && . ~/.profile 

# Setting Android-Environment
RUN sdkmanager "system-images;android-29;google_apis;x86_64" \
    && sdkmanager "platforms;android-29"    \
    && sdkmanager "platform-tools"  \
    && sdkmanager "patcher;v4"  \
    && sdkmanager "emulator"    \
    && sdkmanager "build-tools;29.0.2"



