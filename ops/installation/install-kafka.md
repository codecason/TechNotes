# 1. install java

# 2. install zookeeper
# login as a normal user with sudo privilege
wget https://course-public-resources-1252758970.cos.ap-chengdu.myqcloud.com/PracticalApplication/202001bigdata/9-kafka/apache-zookeeper-3.5.6-bin.tar.gz

mkdir /opt/zookeeper
tar -zxf apache-zookeeper-3.5.6-bin.tar.gz -C /opt/zookeeper

echo "export ZK_HOME=/opt/zookeeper" >> /etc/profile && 
echo "export PATH=$ZK_HOME/bin:$PATH" >> /etc/profile
source /etc/profile
cd /opt/zookeeper/conf && cp zoo_sample.cfg ./zoo.cfg
sudo /opt/zookeeper/bin/zkServer.sh start


# 3. install kafka

<!-- curl https://downloads.apache.org/kafka/2.6.2/kafka_2.13-2.6.2.tgz -o ./kafka-2.13.tgz -->
curl https://archive.apache.org/dist/kafka/2.6.2/kafka_2.13-2.6.2.tgz -o ./kafka-2.13.tgz  
mkdir kafka && tar -xzf kafka-2.13.tgz -C kafka
cd kafka
sudo ./bin/kafka-server-start.sh -daemon config/server.properties

# test kafka
sudo ./bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic TutorialTopic
