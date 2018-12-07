# ///// INITIAL CONFIG /////
# Linux image to run application on
FROM registry.access.redhat.com/rhel7.5
MAINTAINER Nathan Wright <nate01776@gmail.com>

# Build variable store
WORKDIR /readyapi
ARG ls_address=127.0.0.1
ARG project_path="" 
ARG sub_manager_username=""
ARG sub_manager_pwd=""
ENV ls_address=$ls_address
ENV project_path=$project_path
ENV sub_manager_username=$sub_manager_username
ENV sub_manager_pwd=$sub_manager_pwd

# Update and add java package
RUN subscription-manager register --username=${sub_manager_username} --password=${sub_manager_pwd} --auto-attach
RUN (echo "y") | yum install java-1.8.0-openjdk* -y

# ///// HANDLE READY API /////
# Create unpack directory, move test script into test folder, license JAR into licensing
RUN mkdir ./reports
COPY ./licensing/ready-api-license-manager-1.2.2.jar ./licensing/
COPY ./startup_test/basic-project-readyapi-project.xml ./startup_test/
COPY ${project_path} ./project/run.xml

# Download 2.3.0 tarball from Smartbear + unpack
ADD http://dl.eviware.com/ready-api/2.5.0/ReadyAPI-x64-2.5.0.sh ./
RUN chmod +x ./ReadyAPI-x64-2.5.0.sh
RUN ./ReadyAPI-x64-2.5.0.sh -q -dir ./ReadyAPI-2.5.0

# Clean up
RUN rm ./ReadyAPI-x64-2.5.0.sh
RUN chmod +x ./ReadyAPI-2.5.0/bin/testrunner.sh

# Acquire license, make testrunner executable
RUN (echo "1") | java -jar ./licensing/ready-api-license-manager-1.2.2.jar -s ${ls_address}:1099

# Smoke test run when container builds container
RUN sh ./ReadyAPI-2.5.0/bin/testrunner.sh "-EDefault environment" ./startup_test/basic-project-readyapi-project.xml

# ///// TEST EXECUTION /////
# Executable
ENTRYPOINT [ "./ReadyAPI-2.5.0/bin/testrunner.sh" ]

# Default command
CMD ["-EDefault environment", "-f./reports", "-RJUnit-Style HTML Report", "./project/run.xml"]