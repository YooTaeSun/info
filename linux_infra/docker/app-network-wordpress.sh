docker run -d -p 8080:80 \
--network=app-network \
-e WORDPRESS_DB_HOST=mysql \
-e WORDPRESS_DB_NAME=wp \
-e WORDPRESS_DB_USER=wp \
-e WORDPRESS_DB_PASSWORD=wp \
wordpress
