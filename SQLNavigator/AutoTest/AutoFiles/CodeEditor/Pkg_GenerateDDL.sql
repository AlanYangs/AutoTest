CREATE OR REPLACE PACKAGE auto_pkg_codeCompletion
  IS
Type all_tab_type is table of auto_tab_emp%rowtype;
   FUNCTION function_name(a NUMBER,b NUMBER)
     RETURN  all_tab_type pipelined;
END;