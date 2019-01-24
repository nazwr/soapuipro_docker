# RHEL

------
## BUILD
``` sh
  $ docker build \
      --build-arg ls_address=[server_address] \
      --build-arg project_path=[project_path] \
      --build-arg sub_manager_username=[username] \
      --build-arg sub_manager_pwd=[pwd] \
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
      --build-arg sub_manager_username=awesomeLoginName \
      --build-arg sub_manager_pwd=superSecretPwd \
      -t soapui:rhel .
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
  $ docker run soapui:project_3 \
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
