# Linux image to run application on
FROM ubuntu:16.04

# Update
RUN apt-get update
RUN mkdir ./readyapi

# Download 2.3.0 tarball from Smartbear
ADD http://dl.eviware.com/ready-api/2.3.0/ReadyAPI-2.3.0-linux-bin.tar.gz ./readyapi/
RUN tar -xzf ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz
# Unpackage downloaded tarball
RUN ls
RUN ls ./ReadyAPI-2.3.0
