```
docker build \
      --build-arg ls_address=172.22.145.113 \
      --build-arg project_path=./readyapi_project.xml \
      -t readyapi_basic_container .


docker run readyapi_basic_container

docker run readyapi_basic_container \
      "-sTestSuite 1" \
      "-cTestCase 1" \
      "-EDefault environment" \
      "./readyapi/project/run.xml"
```