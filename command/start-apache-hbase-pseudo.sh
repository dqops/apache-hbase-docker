#!/bin/bash

/usr/sbin/start-apache-hadoop-pseudo-yarn.sh
su hadoop -c "${HBASE_HOME}/bin/start-hbase.sh"
