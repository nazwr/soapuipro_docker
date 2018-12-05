# SOAPUI PRO & DOCKER
This branch is intended to support RHEL based execution in a container based environment. This is a *work in progress*, and the full feature set found in the SoapUI Testrunner has not been tested on the container version.

This implementation of SoapUI and Docker requires building the project file into the container, and then passing arguments to tailor how it will run outside of the default full project execution. This means that dependencies on the host machine are kept to an absolute minimum (the intent being this will run in a dynamic infrastructure). Ideally, the image would support pulling as needed from a GIT repo as an alternative in the future.

**This is not supported by Smartbear - please submit all feedback/bugs in this repository.**

------
## REQUIREMENTS & RESTRICTIONS
- Docker 17.09 +
- Valid SoapUI PRO floating license
- License hosted on Protection floating license server and [configured as described in official docs](https://support.smartbear.com/readyapi/docs/general-info/licensing/activate/floating/configure-license-server.html).
- Local project file
- **Currently only supports flat XML projects (default type)**

------
## CLONE REPOSITORY
``` sh
$ git clone https://github.com/nate01776/soapuipro_docker.git
$ cd ./soapui_docker
```

------
## BUILD
``` sh
  $ docker build \
      --build-arg ls_address=[server_address] \
      --build-arg project_path=[project_path] \
      --build-arg sub-manager-username=[username] \
      --build-arg sub-manager-pwd=[pwd] \
      -t [tag_name] .
```

- **server_address (REQ)**: License server IP address or hostname
- **project_path (REQ)**: Local path of project XML to be built into container
- **tag_name**: Tag associated w/build (eg. soapuiproject).
- **sub-manager-username**: RedHat requires an active subscription to their service in order to utitilze the subscription manager this image leans on to install the Java dependencies. The username should be passed here.
- **sub-manager-pwd**: As above, but the corresponding password.
- ***The XML project file should be copied into the same repository the container will be built from***
- *This build sees significant time savings over the Ubuntu based image, and will typically take ~2 minutes depending on available resources*


### EXAMPLE
```sh
  $ docker build \
      --build-arg ls_address=127.0.0.1 \
      --build-arg project_path=./readyapi_project.xml \
      --build-arg sub-manager-username=awesomeLoginName \
      --build-arg sub-manager-pwd=superSecretPwd \
      -t soapuiproject .
```

------
## RUN
### AS FULL PROJECT
```sh
$ docker run [tag_name]
```
- **tag_name**: Same tag as from build step.

### WITH ARGUMENTS
```sh
  $ docker run [tag_name] \
      "[readyapi_arguments]" \
      "./readyapi/project/run.xml"
```
- **tag_name**: Same tag as from build step. 
- **readyapi_arguments**: Commands should be passed in as they would against the testrunner, these are mapped to the runner inside of the container and executed. Ensure the full list - including the project run file - is wrapped as a string.

### EXAMPLE
```sh
  $ docker run soapuiproject \
      "-sTestSuite 1" \
      "-cTestCase 1" \
      "-EDefault environment" \
      "./readyapi/project/run.xml"
```
[More information on the associated arguments can be found in the official documentation.](https://support.smartbear.com/readyapi/docs/soapui/running/automating/cli.html)

------

## FUTURE
- Support packaged projects instead of XML files - this will allow inclusion of Datasources in some of the standard types, as well as potentially composite projects.
- Support for composite projects on local machine
- Support ability to pull composite project from repository endpoint
- Support for all report types
