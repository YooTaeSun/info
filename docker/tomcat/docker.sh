#!/bin/bash
name=tomcat

echo "====== $name ====="
docker stop $name 
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 18080:18080 \
	-p 443:8443 \
	-v /docker/tomcat/data/conf:/usr/local/tomcat/conf \
	-v /docker/tomcat/data/logs:/usr/local/tomcat/logs \
	-v /docker/tomcat/data/webapps:/usr/local/tomcat/webapps \
	-v /root/.m2:/root/.m2 \
	-v /docker/tomcat/data/jenkins:/root/.jenkins \
$name:8.0
echo "====== $name run  ====="


