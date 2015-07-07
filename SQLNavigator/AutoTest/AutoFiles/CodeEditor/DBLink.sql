--create dblink
CREATE DATABASE LINK AUTO_DBLINK_MLUO
  CONNECT TO navdev IDENTIFIED BY navdev
  USING '10.30.152.244/pdb1'
/
--query
select * from auto_tab_dblink@AUTO_DBLINK_MLUO;