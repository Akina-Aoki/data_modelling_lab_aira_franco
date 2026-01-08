# Testing Docker image
[Repo Instructions here](https://github.com/AIgineerAB/data_platform_course/tree/main/05_docker_image)
[Youtube Instructions here](https://www.youtube.com/watch?v=Ds1S725l_EE)

## File path to work with for test: 
`test_python_docker`

- Verify Python 3.11 is installed
```bash
docker run --rm test_python_docker python --version
```

- Validate docker image is running (test_python_docker)
```bash
docker build -t test_python_docker .
docker run --rm test_python_docker
```

Should show in Docker logs:
![Show in container and images](assets/1.png)

Should show in terminal:
![Show table in terminal](assets/2.png)

