# <= version 5.8
docker run -itd --name mysql-test -p 3307:3306 -e MYSQL_ROOT_PASSWORD=root1234 -v /data/mysql-test:/var/lib/mysql mysql:5.7

#  GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'youpassword' WITH GRANT OPTION;  
#  FLUSH   PRIVILEGES;  
# version 8.0
docker run -itd --name mysql-test -p 3307:3306 -e MYSQL_ROOT_PASSWORD=root1234 -v /data/mysql-test:/var/lib/mysql mysql:8.0 --default_policy=mysql_native_password
