FROM ubuntu:18.04
# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget
RUN apt install usbutils -y
# Setup node
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs -y

#FIRESTORE CLI
RUN npm install -g firebase-tools

# Setup new user
RUN useradd -ms /bin/bash developer
RUN usermod -a -G root developer
RUN usermod -a -G plugdev developer

#RUN apt install adb -y
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/Sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/Sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Setup Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/Sdk/tools
RUN cd Android/Sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/Sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin:/home/developer/flutter/bin/cache/dart-sdk/bin:~/Android/Sdk/platform-tools"

# Run basic check to download Dark SDK
RUN flutter channel stable
RUN flutter upgrade
RUN flutter doctor

RUN node -v
RUN npm -v
RUN flutter -v

ENTRYPOINT ["flutter"]
