select e.empno,
(select e from dual) broken
from auto_tab_emp e;