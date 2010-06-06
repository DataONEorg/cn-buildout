#!/bin/bash
## expand the war file
/etc/init.d/mysql stop
/etc/init.d/mysql start

## make knb directory and extract cn.war into it.
echo "Configuring mysql,packaging files, importing data to solr, and indexing solr"
#mysqladmin -u root password 'dataone'
cd /var/mercury/mercury_dev/datanet/
mysql -u root -pdataone < datanet_setup.sql
#java -Xms512m -Xmx1024m -jar  Harvest_dataone.jar datanet ornldaac nodebug daac
#java -Xms512m -Xmx1024m -jar Solr_feed_R23.jar datanet ornldaac nodebug mercury3_harvests_datanet datanet.log datanet_schema_xpath2.xml

java -Xms512m -Xmx1024m -jar dataone-cn-packager-0.4.0.jar

java -Xms512m -Xmx1024m -jar  Harvest_dataone.jar datanet daacpackage nodebug daac
java -Xms512m -Xmx1024m -jar Solr_feed_R23.jar datanet daacpackage nodebug mercury3_harvests_datanet datanet.log datanet_schema_xpath2.xml

