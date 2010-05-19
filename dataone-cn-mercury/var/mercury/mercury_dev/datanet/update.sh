mysql -u root -pdataone < /var/mercury/mercury_dev/datanet/datanet_setup.sql
java -Xms512m -Xmx1024m -jar  /var/mercury/mercury_dev/datanet/Harvest_dataone.jar datanet ornldaac nodebug daac
java -Xms512m -Xmx1024m -jar /var/mercury/mercury_dev/datanet/Solr_feed_R23.jar datanet ornldaac nodebug mercury3_harvests_datanet datanet.log datanet_schema_xpath2.xml
