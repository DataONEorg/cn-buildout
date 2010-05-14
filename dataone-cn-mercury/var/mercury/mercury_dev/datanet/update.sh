mysql -u mercuryuser -pmercury3user < datanet_setup.sql
java -Xms512m -Xmx1024m -jar  Harvest_dataone.jar datanet ornldaac nodebug daac
java -Xms512m -Xmx1024m -jar Solr_feed_R23.jar datanet ornldaac nodebug mercury3_harvests_datanet datanet.log datanet_schema_xpath2.xml
