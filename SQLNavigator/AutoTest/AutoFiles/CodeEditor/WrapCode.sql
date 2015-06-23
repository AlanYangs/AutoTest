--Testing Wrap Code
--begin
PROCEDURE auto_proc_testwrapcode
IS
/**************Cutting Line**************/
BEGIN
    --center
    SELECT 'Testing Wrap Code' AS content, SYSDATE FROM DUAL;
    --output
    DBMS_OUTPUT.put_line ('Test Wrap Code');
END;
--end