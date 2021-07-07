FROM node:12.5.0-alpine

ENV HOME="/sharehack" \
  LANG=C.UTF-8 \
  TZ=Asia/Tokyo \
  HOST=0.0.0.0

WORKDIR ${HOME}

RUN apk update && \
  apk upgrade && \
  npm install -g n && \
  yarn install &&\
  rm -rf /var/cache/apk/*
