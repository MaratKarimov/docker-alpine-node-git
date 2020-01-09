# base image
FROM mhart/alpine-node:6.17.1
# install GIT for container
RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh
