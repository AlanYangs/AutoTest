PROCEDURE auto_proc_testwrapcode
IS
/**************Cutting Line**************/
BEGIN
    
    SELECT 'Testing Wrap Code' AS content, SYSDATE FROM DUAL;
    
    DBMS_OUTPUT.put_line ('Test Wrap Code');
END;

