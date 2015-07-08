CREATE OR REPLACE
PACKAGE BODY aaaaaa
IS
   PROCEDURE x
   IS
   BEGIN
       DELETE FROM cognos.co01_part t1
             WHERE t1."/BIC/ZKONSFLAG" = 'Z';
   END;
END;
/  -- everything after z looks like commented
