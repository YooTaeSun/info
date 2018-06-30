#!/bin/bash

name=jenkins

echo "====== $name ====="
docker stop $name 
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 8080:8080 \
	-p 50000:50000 \
        -v /docker/$name/data:/var/jenkins_home \
$name:2.7.2
echo "====== $name run  ====="
