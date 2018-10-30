## Docker build: PHP 7.1, Mysql, Centos, Redis, Supervisord, Node
REQUIRED:
 * docker
 * docker-compose

Build && run docker

> ``docker-compose up --build`` (optional: add ``sudo`` if ubuntu)

Docker commands list:
 * ``docker-compose up --build`` - boot and rebuild images/packages
 * ``docker ps`` - view the list of containers
 * ``docker exec -it <container name> bash`` - SSH access to the container has been up
 * ``docker-compose down`` - turn off the docker container is running
 * ``docker rmi <id-image>`` - remove image
 * ``docker rm <id/name-container>`` - remove container
 * ``docker system prune -a --volumes`` - remove all container, images, volumes, cache...

 Structure:
 * /app: all source code goes here
 * /conf.d: all config of docker goes here
 * /stores: data DB...
 * docker-compose.yml: file config run docker-compose
 * Dockerfile: file build-in of docker