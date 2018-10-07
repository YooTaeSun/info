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



docker run --restart=always --name mysql -p 3306:3306 -v /var/lib/mysql:/c/docker/mysql/data -v /etc/mysql/conf.d:/c/docker/mysql/conf.d -e MYSQL_ROOT_PASSWORD=1234 -d mysql:8.0.12 --character-set-server=utf8 --collation-server=utf8_unicode_ci 

docker cp mysql:/etc/mysql/conf.d mysql/conf.d
docker cp mysql:/var/lib/mysql mysql/data

docker-machine ip

--------------
-d 백그라운드에서 실행
docker run --name wordpress --link mysql:mysql -p 8080:80 -d wordpress:latest
