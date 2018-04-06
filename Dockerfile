# Linux image to run application on
FROM ubuntu:16.04

# Update OS and add python package
RUN apt-get update

# Create unpack directory
RUN mkdir ./readyapi

# Download 2.3.0 tarball from Smartbear + unpack
ADD http://dl.eviware.com/ready-api/2.3.0/ReadyAPI-2.3.0-linux-bin.tar.gz ./readyapi/
RUN tar -xzf ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz --directory ./readyapi/

# Clean up
RUN rm ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz

# Unpackage downloaded tarball
RUN ls
RUN echo "///////////////////////////////"
RUN ls ./readyapi
