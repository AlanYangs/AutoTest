--UNION clause
select * from auto_tab_emp where empno in
(select empno from auto_tab_emp where empno > 9000 
UNION 
select 2 as empno from dual);


select ename from auto_tab_emp union 
select ename from auto_tab_emp where ename not in (select ename from auto_tab_emp_log) 
order by 1; 