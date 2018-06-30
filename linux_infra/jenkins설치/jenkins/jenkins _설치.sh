jenkins 설정 
————————————————————————
tomcat Encoding 처리
setenv.sh
#!/bin/sh
CATALINA_OPTS="$CATALINA_OPTS -Dfile.encoding=UTF-8"
————————————————————————

Jenkins
http://localhost:8180/jenkins/job/CSE_WEB_DEV/configure
http://localhost:8180/jenkins/

cd /Users/company/Documents/jenkins-instance

폴더에  
jenkins-instance

logs

tomcat -> /Users/company/Documents/hcc/tomcat/tomcat8.5
Tomcat link


ip-192-168-0-232:Documents company$ cd /Users/company/Documents/jenkins-instance
ip-192-168-0-232:jenkins-instance company$ ls -al
total 32
drwxr-xr-x  10 company  staff   340  8 29 13:08 .
drwx------+ 20 company  staff   680  8 29 11:30 ..
-rw-r--r--@  1 company  staff  6148  8 29 13:08 .DS_Store
drwx------@ 13 company  staff   442  8 29 11:30 conf
drwxr-xr-x   8 company  staff   272  8 29 11:30 logs
-rwxr--r--   1 company  staff   172  8 29 11:29 shutdown.sh
-rwxr--r--   1 company  staff   403  8 29 11:28 startup.sh
drwxr-xr-x   4 company  staff   136  8 29 12:44 temp
drwxr-xr-x   5 company  staff   170  8 29 13:08 webapps
drwxr-xr-x   3 company  staff   102  8 29 11:31 work


startup.sh
————————————————————
#!/usr/bin/env bash
export CATALINA_HOME=/Users/company/Documents/tomcat
export CATALINA_BASE=/Users/company/Documents/jenkins-instance
export JAVA_OPTS="-Djava.awt.headless=true -server -Xms512m -Xmx1024m -XX:NewSize=256m -XX:MaxNewSize=256m -XX:PermSize=256m -XX:MaxPermSize=512m -XX:+DisableExplicitGC"
export CATALINA_OPTS="-Denv=jenkins -Denv.servername=jenkins"
cd $CATALINA_HOME/bin
./startup.sh


shutdown.sh

#!/usr/bin/env bash
export CATALINA_HOME=/Users/company/Documents/tomcat
export CATALINA_BASE=/Users/company/Documents/jenkins-instance
cd $CATALINA_HOME/bin
./shutdown.sh

sh 파일 권한
Chmod -744 startup.sh shutdown.sh

————————————————————————————————————————
Tomcat

ip-192-168-0-232:jenkins-instance company$ cd webapps/
ip-192-168-0-232:webapps company$ ls -al
total 137952
drwxr-xr-x   5 company  staff       170  8 29 13:08 .
drwxr-xr-x  10 company  staff       340  8 29 13:08 ..
-rw-r--r--@  1 company  staff      6148  8 29 13:08 .DS_Store
drwxr-x---  24 company  staff       816  8 29 11:31 jenkins
-rw-r--r--@  1 company  staff  70620203  8 29 11:31 jenkins.war


cd server.xml  port 를 다 8180
Webapps 폴더에  jenkins.war 를 넣고

———————————————————————————————


플러그인 
Maven
퍼블


—————