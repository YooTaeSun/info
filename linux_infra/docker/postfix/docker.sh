#!/bin/bash
name=postfix

echo "====== $name ====="
docker stop $name 
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 25:25 \
	-v /docker/postfix/data/postfix:/etc/postfix \
	-v /docker/postfix/data/log:/var/log/postfix \
tozd/$name
echo "====== $name run  ====="


