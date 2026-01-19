# Docker Commands List
| Category             | Purpose                             | Command                                                              |
| -------------------- | ----------------------------------- | -------------------------------------------------------------------- |
| **Sanity check**     | Verify Docker is installed          | `docker --version`                                                   |
|                      | Check Docker engine status          | `docker info`                                                        |
|                      | List running containers             | `docker ps`                                                          |
|                      | List all containers (incl. stopped) | `docker ps -a`                                                       |
| **Images**           | Build image from Dockerfile         | `docker build -t yh-labb-app .`                                      |
|                      | Build image with explicit tag       | `docker build -t yh-labb-app:latest .`                               |
|                      | List local images                   | `docker images`                                                      |
|                      | Inspect image metadata              | `docker inspect yh-labb-app`                                         |
|                      | Remove image                        | `docker rmi yh-labb-app`                                             |
|                      | Force remove image                  | `docker rmi -f yh-labb-app`                                          |
| **Containers**       | Run container (detached)            | `docker run -d --name yh-labb-container yh-labb-app`                 |
|                      | Run with env file                   | `docker run -d --name yh-labb-container --env-file .env yh-labb-app` |
|                      | Run with port mapping               | `docker run -d -p 8000:8000 yh-labb-app`                             |
|                      | Run with env + ports                | `docker run -d --env-file .env -p 8000:8000 yh-labb-app`             |
|                      | Start existing container            | `docker start yh-labb-container`                                     |
|                      | Stop running container              | `docker stop yh-labb-container`                                      |
|                      | Restart container                   | `docker restart yh-labb-container`                                   |
|                      | Remove container                    | `docker rm yh-labb-container`                                        |
|                      | Force remove running container      | `docker rm -f yh-labb-container`                                     |
| **Logs & Debugging** | View container logs                 | `docker logs yh-labb-container`                                      |
|                      | Follow logs (live)                  | `docker logs -f yh-labb-container`                                   |
|                      | Inspect container                   | `docker inspect yh-labb-container`                                   |
| **Shell access**     | Open shell inside container         | `docker exec -it yh-labb-container bash`                             |
|                      | Open shell (sh-based images)        | `docker exec -it yh-labb-container sh`                               |
| **Cleanup**          | Remove all stopped containers       | `docker container prune`                                             |
|                      | Remove unused images                | `docker image prune`                                                 |
|                      | Remove everything unused            | `docker system prune`                                                |
|                      | Aggressive cleanup                  | `docker system prune -a`                                             |
<br>


# Step by step Docker Exectution Commands

| Step | Phase    | Purpose                               | Command                                                                                  |
| ---: | -------- | ------------------------------------- | ---------------------------------------------------------------------------------------- |
|    0 | Setup    | Navigate to lab folder                | `cd /c/Users/adelo/de25/data_modelling_lab_aira_franco/yh_labb`                          |
|    1 | Setup    | Verify required files exist           | `ls`                                                                                     |
|    2 | Validate | Check Docker installation             | `docker --version`                                                                       |
|    3 | Validate | Confirm Docker engine is running      | `docker info`                                                                            |
|    4 | Validate | List running containers               | `docker ps`                                                                              |
|    5 | Build    | Build image from Dockerfile           | `docker build -f dockerfile -t yh-labb-app:latest .`                                     |
|    6 | Build    | Verify image was created              | `docker images`                                                                          |
|    7 | Cleanup  | Remove old container (if exists)      | `docker rm -f yh-labb-container`                                                         |
|    8 | Run      | Run container with env vars and ports | `docker run -d --name yh-labb-container --env-file .env -p 8000:8000 yh-labb-app:latest` |
|    9 | Verify   | Confirm container is running          | `docker ps`                                                                              |
|   10 | Verify   | View container logs                   | `docker logs yh-labb-container`                                                          |
|   11 | Verify   | Follow logs live                      | `docker logs -f yh-labb-container`                                                       |
|   12 | Verify   | Check port mapping                    | `docker port yh-labb-container`                                                          |
|   13 | Debug    | Open shell inside container           | `docker exec -it yh-labb-container bash`                                                 |
|   14 | Debug    | Verify env variables inside container | `printenv \| grep POSTGRES`                                                              |
|   15 | Debug    | Verify working directory and files    | `pwd && ls`                                                                              |
|   16 | Control  | Exit container shell                  | `exit`                                                                                   |
|   17 | Control  | Stop container                        | `docker stop yh-labb-container`                                                          |
|   18 | Control  | Start existing container              | `docker start yh-labb-container`                                                         |
|   19 | Control  | Restart container                     | `docker restart yh-labb-container`                                                       |
|   20 | Rebuild  | Stop and remove container             | `docker stop yh-labb-container && docker rm yh-labb-container`                           |
|   21 | Rebuild  | Rebuild image after code changes      | `docker build -f dockerfile -t yh-labb-app:latest .`                                     |
|   22 | Cleanup  | Remove container after lab            | `docker rm -f yh-labb-container`                                                         |
|   23 | Cleanup  | Remove image                          | `docker rmi yh-labb-app:latest`                                                          |
|   24 | Cleanup  | Remove unused Docker resources        | `docker system prune`                                                                    |
