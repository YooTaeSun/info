#!/bin/bash
name=oralce

echo "====== $name ====="
docker stop $name
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 49160:22 \
	-p 49161:1521 \
	-p 49162:8080 \
dkfi/docker-oracle-xe-10g
echo "====== $name run  ====="
