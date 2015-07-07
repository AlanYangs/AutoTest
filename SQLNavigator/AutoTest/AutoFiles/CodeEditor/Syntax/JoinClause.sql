--JOIN clause
select * from auto_tab_emp
inner join auto_tab_emp_log
on auto_tab_emp.ename = auto_tab_emp_log.ename;

select * from (auto_tab_emp_log 
inner join auto_tab_emp
on auto_tab_emp_log.ename = auto_tab_emp.ename);

select * from auto_tab_emp_log a, auto_tab_emp b
where a.ename(+) = b.ename;