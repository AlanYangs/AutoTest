--drop
DROP DATABASE LINK ALAN_DBLINK_MLUO;

--create dblink
CREATE DATABASE LINK ALAN_DBLINK_MLUO
  CONNECT TO navdev IDENTIFIED BY navdev
  USING '10.30.152.244/pdb1'
/

--query
SELECT * FROM auto_tab_dblink@alan_dblink_mluo;