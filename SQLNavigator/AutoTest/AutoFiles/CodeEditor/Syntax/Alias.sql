select e.*,d.*
from auto_tab_emp e, auto_tab_department d
where e.deptno = d.id;

SELECT e1.*, e2.*
from auto_tab_emp e1, auto_tab_emp e2
where e1.mgr = e2.empno;

select * from auto_tab_emp where auto_tab_emp.job = 'MANAGER';