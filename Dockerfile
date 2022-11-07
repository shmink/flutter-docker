FROM debian:stable-slim

RUN apt update
RUN apt install -y curl git unzip
RUN apt clean

RUN git clone -b stable --depth 1 https://github.com/flutter/flutter.git /usr/local/flutter

RUN chmod 755 -R /usr/local/flutter
ENV PATH="${PATH}:/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin"

RUN flutter channel stable
RUN flutter upgrade
RUN flutter config --enable-web
RUN flutter doctor -v
RUN echo "export PATH="$PATH":"$HOME/.pub-cache/bin"" >> $HOME/.bashrc

RUN git config --global --add safe.directory /usr/local/flutter