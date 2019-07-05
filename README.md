Apache HBase Dockerfiles for a Single Node Cluster

# [standalone](http://hbase.apache.org/book.html#quickstart)

## build
```
$ docker build --build-arg HBASE_VERSION="2.1.5" \
-t kirasoa/apache-hbase-standalone:2.1.5 \
-t kirasoa/apache-hbase-standalone:latest \
-f Dockerfile.standalone .
```
## run
On Mac, you need to assign a hostname (e.g. "docker-host") to a container and have it resolved as "127.0.0.1/localhost" due to a zookeeper restriction. The easiest way is to edit /etc/hosts.
```
$ sudo vi /etc/hosts
...
127.0.0.1	localhost docker-host
...
$ docker run -h docker-host --name apache-hbase-standalone --rm -d \
-p 16000:16000 -p 16010:16010 -p 16020:16020 -p 16030:16030 -p 2181:2181 \
-v ${PWD}:/workspace kirasoa/apache-hbase-standalone:latest
$ docker exec -ti apache-hbase-standalone bash
root@docker-host:/workspace# jps
72 HMaster
431 Jps
root@docker-host:/workspace# hbase shell
...
hbase(main):001:0>
```

# [pseudo-distributed](http://hbase.apache.org/book.html#quickstart_pseudo)

## build
```
$ docker build --build-arg HBASE_VERSION="2.0.5" \
-t kirasoa/apache-hbase-pseudo:2.0.5 \
-f Dockerfile.pseudo .
```
## run
```
$ sudo vi /etc/hosts
...
127.0.0.1	localhost docker-host
...
$ docker run -h docker-host --name apache-hbase-pseudo --rm -d \
-p 50070:50070 -p 9000:9000 \
-p 50010:50010 -p 50075:50075 -p 50020:50020 \
-p 8031:8031 -p 8030:8030 -p 8032:8032 -p 8088:8088 -p 8033:8033 \
-p 8040:8040 -p 13562:13562 -p 8042:8042 \
-p 10020:10020 -p 19888:19888 \
-p 50100-50105:50100-50105 \
-p 2181:2181 \
-p 16000:16000 -p 16010:16010 \
-p 16020:16020 -p 16030:16030 \
-v ${PWD}:/workspace kirasoa/apache-hbase-pseudo:2.0.5
$ docker exec -ti apache-hbase-pseudo bash
root@docker-host:/workspace# jps
640 ResourceManager
432 SecondaryNameNode
1522 HMaster
1442 HQuorumPeer
982 JobHistoryServer
1638 HRegionServer
745 NodeManager
16106 Jps
124 NameNode
255 DataNode
root@docker-host:/workspace# hbase shell
...
hbase(main):001:0>
```
