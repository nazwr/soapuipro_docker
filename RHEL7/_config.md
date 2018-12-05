docker build \
      --build-arg ls_address=172.22.145.113 \
      --build-arg project_path=./readyapi_project.xml \
      -t readyapi_basic_container .


docker run readyapi_basic_container
      

docker run --mount type=bind,source="C:/Users/nathan.wright/Code/soapuipro_docker/reports",target=/readyapi/reports \
      readyapi_basic_container \
      "-f./readyapi/reports" \
      "-RJUnit-Style HTML Report" \
      "-sTestSuite 1" \
      "-cTestCase 1" \
      "-EDefault environment" \
      "./readyapi/project/run.xml"