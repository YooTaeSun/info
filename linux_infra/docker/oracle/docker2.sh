#!/bin/bash
name=winsent/geoserver

echo "====== $name ====="
docker stop $name
echo "======  $name stop  ====="
docker rm $name
echo "======  $name rm  ====="
docker run -d -it --restart=always --name $name \
	-p 1521:1521 \
	-p 158080:8080
        -v /docker/oracle/data/geoserver_data:/opt/geoserver/data_dir \
$name
echo "====== $name run  ====="
