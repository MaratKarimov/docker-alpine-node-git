# base image
FROM mhart/alpine-node:6.17.1
# install GIT for container
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
# add packages for YARN installation
RUN apk add --no-cache curl gnupg

ENV YARN_VERSION=latest

RUN for server in ipv4.pool.sks-keyservers.net keyserver.pgp.com ha.pool.sks-keyservers.net; do \
    gpg --keyserver $server --recv-keys \
      6A010C5166006599AA17F08146C2130DFD2497F5 && break; \
  done && \
  curl -sfSL -O https://yarnpkg.com/${YARN_VERSION}.tar.gz -O https://yarnpkg.com/${YARN_VERSION}.tar.gz.asc && \
  gpg --batch --verify ${YARN_VERSION}.tar.gz.asc ${YARN_VERSION}.tar.gz && \
  mkdir /usr/local/share/yarn && \
  tar -xf ${YARN_VERSION}.tar.gz -C /usr/local/share/yarn --strip 1 && \
  ln -s /usr/local/share/yarn/bin/yarn /usr/local/bin/ && \
  ln -s /usr/local/share/yarn/bin/yarnpkg /usr/local/bin/ && \
  rm ${YARN_VERSION}.tar.gz*
