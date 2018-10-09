docker stop mysql
docker rm mysql
docker run -d -p 3306:3306 \
-e MYSQL_ALLOW_EMPTY_PASSWORD=true \
--network=app-network \
--name mysql \
mysql:5.7
