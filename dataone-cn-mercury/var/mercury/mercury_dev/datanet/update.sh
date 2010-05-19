#!/bin/bash
## expand the war file
CURR_DIR=`pwd`
/etc/init.d/mysql stop
/etc/init.d/mysql start

## make knb directory and extract cn.war into it.
echo "Configuring mysql, importing data to solr and indexing solr"
cd /var/mercury/mercury_dev/datanet/
mysql -u root -pdataone < datanet_setup.sql
java -Xms512m -Xmx1024m -jar  Harvest_dataone.jar datanet ornldaac nodebug daac
java -Xms512m -Xmx1024m -jar Solr_feed_R23.jar datanet ornldaac nodebug mercury3_harvests_datanet datanet.log datanet_schema_xpath2.xml
echo cd to $CURR_DIR
cd $CURR_DIR


