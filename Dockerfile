FROM debian:stable-slim

RUN apt update
RUN apt-get install -y \
    curl git wget python3 \
    zip unzip apt-transport-https \
    ca-certificates gnupg clang \
    cmake ninja-build pkg-config \
    libgconf-2-4 gdb libstdc++6 \
    libglu1-mesa fonts-droid-fallback \
    libgtk-3-dev
RUN apt-get clean

RUN git clone -b stable --depth 1 https://github.com/flutter/flutter.git /usr/local/flutter

RUN chmod 755 -R /usr/local/flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter doctor -v
RUN echo "export PATH="$PATH":"$HOME/.pub-cache/bin"" >> $HOME/.bashrc

RUN git config --global --add safe.directory /usr/local/flutter