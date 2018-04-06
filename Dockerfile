# Linux image to run application on
FROM ubuntu:16.04
MAINTAINER Nathan Wright <nathan.wright@smartbear.com>

# Update OS and add java package
RUN apt-get update
RUN ((echo "Y")) | apt-get install default-jre
RUN ((echo "Y")) | apt-get install openjfx

# Stand up internal file server OR pull from repository? Pass in test file for starters w/docker repo

# ///// HANDLE READY API /////
# Create unpack directory
RUN mkdir ./readyapi

# Download 2.3.0 tarball from Smartbear + unpack
ADD http://dl.eviware.com/ready-api/2.3.0/ReadyAPI-2.3.0-linux-bin.tar.gz ./readyapi/
COPY basic-project-readyapi-project.xml ./readyapi/testProject
RUN tar -xzf ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz --directory ./readyapi/

# Clean up
RUN rm ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz

# Test container
RUN ls ./readyapi
RUN ./readyapi/ReadyAPI-2.3.0/bin/testrunner.sh "-RProject Report" "-EDefault environment" .\readyapi\testProject\basic-project-readyapi-project.xml
