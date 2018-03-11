#!/bin/bash
name=mysql	

echo "====== $name  ====="
docker stop $name 
echo "======  $name stop  ====="
docker rm $name
echo "====== $name rm  ====="
docker run -d -it --restart=always --name $name \
	-v /docker/mysql/data/conf.d:/etc/mysql/conf.d \
	-v /docker/mysql/data/mysql:/var/lib/mysql	\
	-p 3306:3306 \
	-e MYSQL_ROOT_PASSWORD=1234 \
$name --character-set-server=utf8 --collation-server=utf8_unicode_ci 

echo "====== $name run  ====="


