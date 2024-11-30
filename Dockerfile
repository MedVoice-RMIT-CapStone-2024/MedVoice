## Step 1: Use a specific Flutter image as the base
#FROM ghcr.io/cirruslabs/flutter:3.19.5
#
#ARG android_sdk_ver=34
## Step 1: Use a specific Flutter image as the base
#FROM ghcr.io/cirruslabs/flutter:3.19.5
#
#ARG flutter_ver=3.19.5
#ARG build_rev=0
#
#
## Install Flutter
#ENV FLUTTER_HOME=/usr/local/flutter \
#    FLUTTER_VERSION=${flutter_ver} \
#    PATH=$PATH:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin
#RUN apt-get update \
# && apt-get upgrade -y \
# && apt-get install -y --no-install-recommends --no-install-suggests \
#            ca-certificates \
# && update-ca-certificates \
# && apt-get install -y --no-install-recommends --no-install-suggests \
#            build-essential \
#            clang cmake \
#            lcov \
#            libgtk-3-dev liblzma-dev \
#            ninja-build \
#            pkg-config \
# && curl -fL -o /tmp/flutter.tar.xz \
#         https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${flutter_ver}-stable.tar.xz \
# && tar -xf /tmp/flutter.tar.xz -C /usr/local/ \
# && git config --global --add safe.directory /usr/local/flutter \
# && flutter config --enable-android \
#                   --enable-linux-desktop \
#                   --no-enable-web \
#                   --no-enable-ios \
# && flutter precache --universal --linux --no-web --no-ios \
# && (yes | flutter doctor --android-licenses) \
# && flutter --version \
# && rm -rf /var/lib/apt/lists/* \
#           /tmp/*
#
#
## Set the working directory
#WORKDIR /app
#
## Copy the project files into the container
#COPY . .
#
## Get Flutter dependencies
#RUN flutter pub get
#
## Build the APK
#RUN flutter build apk --release