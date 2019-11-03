# centos7_docker
Dockerfile management.

# image download
docker pull weleek/centos7.ssh.python:1.0.1

# create container from image
docker run -d -it -net bridge -p 22 --name centos7_python weleek/centos7.ssh.python /sbin/init

# access container
docker exec -it -u admin centos7_python /bin/bash

# stop the container
docker stop centos7_python

# start the container
docker start centos7_python


