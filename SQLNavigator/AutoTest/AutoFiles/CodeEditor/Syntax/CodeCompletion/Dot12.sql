select ename,job,
case when e
     when (e.job = 'ANALYST') then 'one'
     when (job = 'CLERK') then 'two'
     else 'More than two'
end as resultset
from auto_tab_emp e;