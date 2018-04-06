# Linux image to run application on
FROM ubuntu:16.04
MAINTAINER Nathan Wright <nathan.wright@smartbear.com>

# Update OS and add python package
RUN apt-get update
RUN apt-get install -qqy ruby ruby-dev
RUN gem install bundler

# Stand up internal file server
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile /app/
RUN bundle install
COPY . /app
EXPOSE 5000
CMD ["bundle", "exec", "rackup", "--host ::", "0.0.0.0", "-p", "5000"]

# ///// HANDLE READY API /////
# # Create unpack directory
# RUN mkdir ./readyapi

# # Download 2.3.0 tarball from Smartbear + unpack
# ADD http://dl.eviware.com/ready-api/2.3.0/ReadyAPI-2.3.0-linux-bin.tar.gz ./readyapi/
# RUN tar -xzf ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz --directory ./readyapi/

# # Clean up
# RUN rm ./readyapi/ReadyAPI-2.3.0-linux-bin.tar.gz

# # Unpackage downloaded tarball
# RUN ls ./readyapi
