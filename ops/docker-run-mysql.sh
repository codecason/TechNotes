
docker run -itd --name mysql-test -p 3307:3306 -e MYSQL_ROOT_PASSWORD=root1234 -v /data/mysql-test:/var/lib/mysql mysql-local:latest
#  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;  
#  FLUSH   PRIVILEGES;  
