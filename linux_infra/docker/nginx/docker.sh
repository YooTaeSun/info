#!/bin/bash
name=nginx

echo "====== $name ====="
docker stop $name 
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 8080:8080 \
	-v /docker/nginx/data/nginx:/etc/nginx \
$name
echo "====== $name run  ====="
