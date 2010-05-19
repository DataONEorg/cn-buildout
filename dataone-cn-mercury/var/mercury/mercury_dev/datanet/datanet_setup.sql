/*
SQLyog Community Edition- MySQL GUI v5.20
Host - 5.0.24-community-nt : Database - mercury3_harvests_datanet
*********************************************************************
Server version : 5.0.24-community-nt
*/

SET NAMES utf8;

SET SQL_MODE='';

create database if not exists `mercury3_harvests_datanet`;
create user mercuryuser identified by 'mercury3user';
grant all privileges on mercury3_harvests_datanet.* to mercuryuser@localhost identified by 'mercury3user' ;
USE `mercury3_harvests_datanet`;

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';

/*Table structure for table `data_source` */

DROP TABLE IF EXISTS `data_source`;

CREATE TABLE `data_source` (
  `instance` varchar(20) NOT NULL,
  `source` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `file_reference` */

DROP TABLE IF EXISTS `file_reference`;

CREATE TABLE `file_reference` (
  `fileURL_ID` int(11) NOT NULL auto_increment,
  `fileURL` text NOT NULL,
  PRIMARY KEY  (`fileURL_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

/*Table structure for table `harvest_info` */

DROP TABLE IF EXISTS `harvest_info`;

CREATE TABLE `harvest_info` (
  `harvest_info_id` int(11) NOT NULL auto_increment,
  `index_id` int(11) NOT NULL,
  `file_ref_id` int(11) NOT NULL,
  `checksum` text NOT NULL,
  `refresh_date` date NOT NULL,
  `update_date` date NOT NULL,
  `prev_harvest_info_id` int(11) default NULL,
  `fileURL` text NOT NULL,
  `end_date` date default NULL,
  `fileURL_ID` int(11) NOT NULL,
  PRIMARY KEY  (`harvest_info_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

/*Table structure for table `index_info` */

DROP TABLE IF EXISTS `index_info`;

CREATE TABLE `index_info` (
  `index_info_id` int(11) NOT NULL auto_increment,
  `instance` varchar(20) NOT NULL,
  `index_name` varchar(20) NOT NULL,
  PRIMARY KEY  (`index_info_id`),
  UNIQUE KEY `Index_2` USING BTREE (`instance`,`index_name`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;



/*Table structure for table `transformed_files` */

DROP TABLE IF EXISTS `transformed_files`;

CREATE TABLE `transformed_files` (
  `file_ref_id` int(11) NOT NULL auto_increment,
  `file_name` text NOT NULL,
  `file_content` longtext NOT NULL,
  `fileURL` text NOT NULL,
  `cksum` text NOT NULL,
  PRIMARY KEY  (`file_ref_id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
