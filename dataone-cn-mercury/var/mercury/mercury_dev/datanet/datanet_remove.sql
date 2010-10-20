/*
SQLyog Community Edition- MySQL GUI v5.20
Host - 5.0.24-community-nt : Database - mercury3_harvests_datanet
*********************************************************************
Server version : 5.0.24-community-nt
*/
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ANSI';
USE mercury3_harvests_datanet ;
DROP PROCEDURE IF EXISTS mercury3_harvests_datanet.drop_user_if_exists ;
DELIMITER $$
CREATE PROCEDURE mercury3_harvests_datanet.drop_user_if_exists()
BEGIN
  DECLARE foo BIGINT DEFAULT 0 ;
  SELECT COUNT(*)
  INTO foo
    FROM mysql.user
      WHERE User = 'mercuryuser' and  Host = 'localhost';
   IF foo > 0 THEN
	drop user 'mercuryuser'@'localhost';
  END IF;
END ;$$
DELIMITER ;
CALL mercury3_harvests_datanet.drop_user_if_exists() ;
DROP PROCEDURE IF EXISTS mercury3_harvests_datanet.drop_user_if_exists ;
SET SQL_MODE=@OLD_SQL_MODE ;


SET NAMES utf8;

SET SQL_MODE='';

DROP DATABASE IF EXISTS `mercury3_harvests_datanet`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
