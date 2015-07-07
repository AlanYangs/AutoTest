CREATE OR REPLACE 
PACKAGE auto_pkg_codeCompletion
  IS
Type all_tab_type is table of emp%rowtype; 
   FUNCTION function_name(a NUMBER,b NUMBER)
     RETURN  all_tab_type pipelined;
END; -- Package spec
/

CREATE OR REPLACE 
PACKAGE BODY auto_pkg_codeCompletion
IS
    FUNCTION function_name(a NUMBER,b NUMBER)
     RETURN  all_tab_type pipelined
    is
    begin 
      for cur in (select * from emp) loop 
        pipe row(cur); 
      end loop; 
      return; 
    end;
END;
/