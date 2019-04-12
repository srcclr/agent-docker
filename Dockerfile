FROM ubuntu:18.04

RUN apt-get -y update && \
  apt-get install -y curl git && \
  curl -sSL https://download.sourceclear.com/ci.sh | CACHE_DIR=/tmp NOSCAN=1 bash

ENV PATH=/tmp/srcclr/bin:${PATH}