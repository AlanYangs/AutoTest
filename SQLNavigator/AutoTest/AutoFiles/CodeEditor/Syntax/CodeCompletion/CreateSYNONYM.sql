-- synonym of a table in a different schema that contains underscore
CREATE or REPLACE SYNONYM autouser.emp_syn1
  FOR navdev.auto_tab_emp
/

CREATE or REPLACE SYNONYM navdev.emp_syn2
  FOR navdev.auto_tab_emp 
/

-- synonym of a table using dblink
CREATE or REPLACE SYNONYM navdev.testsyn1
  FOR navdev.auto_tab_dblink@alan_dblink_mluo
/

CREATE or REPLACE SYNONYM navdev.emp_syn3
  FOR navdev.auto_tab_dblink@alan_dblink_mluo
/

-- synonym of a table using dblink (navdev.department)
CREATE or REPLACE SYNONYM navdev.dept_syn1
  FOR navdev.department@alan_dblink_mluo
/

-- synonym of a view in a different schema, this synonym has the same name as the original table
CREATE OR REPLACE VIEW department_view (
   id,
   name,
   location )
AS
select "ID","NAME","LOCATION" from navdev.department
/

CREATE or REPLACE SYNONYM autouser.department1
  FOR navdev.department_view
/

-- synonym of a package in the current schema
CREATE or REPLACE SYNONYM navdev.at_test_syn1
  FOR navdev.at_test
/

-- synonym of a package in a different schema 
CREATE or REPLACE SYNONYM navdev.at_test_syn2
  FOR navdev.at_test
/

-- synonyms that have the same name (one private, one public)
CREATE or REPLACE SYNONYM navdev.authors_syn1
  FOR navdev.authors
/

CREATE or REPLACE PUBLIC SYNONYM authors_syn1
  FOR navdev.authors
/

-- a public synonym that has the same name as a table 
CREATE or REPLACE PUBLIC SYNONYM complex_type_table
  FOR navdev.complex_type_table
/

-- synonym of a user-defined type
CREATE or REPLACE SYNONYM navdev.person_syn1
  FOR navdev.person
/

-- synonym of a user-defined type of a different schema
CREATE or REPLACE SYNONYM autouser.person_syn2
  FOR navdev.person
/

-- synonym of a procedure
CREATE or REPLACE SYNONYM navdev.author_sel_syn1
  FOR navdev.author_sel
/

-- synonym of a materialized view (need another one belong to a different schema)
CREATE or REPLACE SYNONYM navdev.mv_rewrite_syn1
  FOR navdev.mv_rewrite
/

-- synonym of synonym
CREATE or REPLACE SYNONYM navdev.emp_syn1_syn1
  FOR navdev.emp_syn1
/