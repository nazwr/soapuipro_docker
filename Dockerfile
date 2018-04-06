# Linux image to run application on
FROM ubuntu:16.04
MAINTAINER Nathan Wright <nathan.wright@smartbear.com>

# Update OS and add python package
RUN apt-get update \
    && apt-get install -y nodejs \
    && apt-get install -y npm

# Create unpack directory
RUN mkdir ./readyapi

# Download 2.3.0 tarball from Smartbear + unpack
ADD http://dl.eviware.com/ready-api/2.3.0/ReadyAPI-2.3.0-linux-bin.tar.gz ./readyapi/
RUN tar -xzf ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz --directory ./readyapi/

# Clean up
RUN rm ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz

# Unpackage downloaded tarball
RUN ls ./readyapi
