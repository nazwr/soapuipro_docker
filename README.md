![Docker Logo](http://linux-command.org/dist/assets/images/docker/main.jpg)

# SOAPUI PRO FOR DOCKER
This project was created to aid in the execution of SoapUI PRO tests in container based environments. This is a *work in progress*, and the full feature set found in the SoapUI Testrunner has not been tested on the container version.

This implementation of SoapUI and Docker requires building the project file into the container, and then passing arguments to tailor how this will run outside of the default full project execution. More details can be found below.

**SoapUI PRO** is part of Smartbear's ReadyAPI testing suite, a fully fledged, API specific set of tools designed to cover functional, security and performance testing - as well as API virtualization. [For more information on using SoapUI PRO, please visit the Smartbear website.](https://smartbear.com/product/ready-api/soapui/overview/)

Please submit all feedback/bugs as issues in this repository.

------
## REQUIREMENTS & RESTRICTIONS

- Valid SoapUI PRO floating license
- License hosted on Protection floating license server and [configured as described in official docs](https://support.smartbear.com/readyapi/docs/general-info/licensing/activate/floating/configure-license-server.html).
- Local project file, XML format.
- **Currently only supports flat XML projects (default type)**

------
## PULL REPOSITORY
``` sh
git pull https://github.com/nate01776/dockerSUI.git
```
```sh
cd ./dockerSUI
```

------
## BUILD
``` sh
docker build --build-arg ls_address=[server_address] --build-arg project_path=[project_path] -t [tag_name] .
```
- ***server_address***: License server IP address or hostname
- ***project_path***: Local path of project XML to be built into container
- ***tag_name***: Tag associated w/build.
- *Build will typically take ~5 minutes depending on available resources*

------
## RUN
### AS FULL PROJECT
```sh
docker run [tag_name]
```
- ***tag_name***: Same tag as from build step.

### WITH ARGUMENTS
```sh
docker run [tag_name] '[readyapi_arguments] ./readyapi/project/run.xml'
```
- ***tag_name***: Same tag as from build step. 
- ***readyapi_arguments***: Commands should be passed in as they would against the testrunner, these are mapped to the runner inside of the container and executed. Ensure the full list - including the project run file - is wrapped as a string.
------

## READYAPI ARGUMENTS EXAMPLE
```sh
docker run soapuipro "-sTestSuite 1" "-cTestCase 1" "-EDefault environment" ./readyapi/project/run.xml
```
[More information on the associated arguments can be found in the official documentation.](https://support.smartbear.com/readyapi/docs/soapui/running/automating/cli.html)

------

## FUTURE GOALS
- Support packaged projects instead of XML files - this will allow inclusion of Datasources in some of the standard types, as well as potentially composite projects.
- Thin down base image instead of using full ubuntu.
- Support for composite projects on local machine
- Support ability to pull composite project from repository endpoint
- Support for all report types
