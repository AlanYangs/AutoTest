drop table auto_tab_emp;

-- Tested Table 1
CREATE TABLE auto_tab_emp
(
    empno      NUMBER (4, 0),
    ename      VARCHAR2 (10 BYTE),
    job        VARCHAR2 (9 BYTE),
    mgr        NUMBER (4, 0),
    hiredate   DATE,
    sal        NUMBER (7, 2),
    comm       NUMBER (7, 2),
    deptno     NUMBER (2, 0)
);


--Tested Table 2
drop table auto_tab_department;

CREATE TABLE auto_tab_department
(
    id         NUMBER NOT NULL,
    name       VARCHAR2 (50),
    location   VARCHAR2 (100)
);


