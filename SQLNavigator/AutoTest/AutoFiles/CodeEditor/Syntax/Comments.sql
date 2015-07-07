--multi line comments are placed at different positions
select * from emp
/
/*test comment*/

select * from emp
/ --test comment

-- comment at the end
select            * from DUAL;                                 --comment

-- multi-line comment on the next line
select            * from DUAL;                        --comment
    /*
    comment
    */

--multi-line comment before semi-colon
select            * from DUAL                                      /*comment*/;