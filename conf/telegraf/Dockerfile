FROM ubuntu AS build
ARG VERSION

ARG DEBIAN_FRONTEND="noninteractive" 

RUN \
 apt-get update &&\
 apt-get install -yf \
  build-essential \
  ruby-dev \
  rubygems \
  git \
  golang 

RUN \
 gem install --no-document fpm

RUN \
 git clone https://github.com/marcelmaatkamp/telegraf.git

WORKDIR /telegraf
RUN \
 make $(make help | grep 'telegraf.*\amd64.deb' | awk '{$1=$1};1')

FROM telegraf
ARG VERSION

COPY --from=build /telegraf/build/dist/telegraf_${VERSION}_amd64.deb telegraf_${VERSION}_amd64.deb
RUN \
 dpkg -i telegraf_${VERSION}_amd64.deb &&\
 rm -rf telegraf_${VERSION}_amd64.deb
