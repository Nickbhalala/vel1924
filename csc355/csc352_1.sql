@C:\Users\bhala\Downloads\Oracle_sample_crt_employees_Countires_script_edited.sql



--Q1

select employee_id, (last_name || ',' || first_name )as fullName, to_char (salary,  '$999,999') salary , department_id
                                                                                from employees
                                                                                WHERE manager_id = 101;
COMMIT;
---Q2
select employee_id, (last_name || ',' || first_name )as fullName, to_char (salary,  '$999,999') salary , department_id 
                                                                        from  employees
                                                                       where manager_id = (select employee_id from employees
                                                            where upper(last_name) ='KOCHHAR' and upper(first_name) ='NEENA');
COMMIT;
--Q3
select employee_id, (last_name || ',' || first_name )as fullName,  department_id 
                                                                                from employees  
                                                                              where (first_name) LIKE( 'C%');
COMMIT;
--Q4
SELECT  departments.department_id, departments.department_name   , count(employees.employee_id)   FROM employees inner join departments on employees.department_id = departments.department_id
group by departments.department_id ,departments.department_name
 order by departments.department_id asc;
 COMMIT;
 
 --Q5
 
 select  (last_name || ',' || first_name )as fullName, to_char (salary,  '$999,999') salary  from employees
 where department_id is NULL;
 COMMIT;
 
 --Q6
 SELECT  departments.department_id,  max(to_char (salary  + (NVL( commission_pct ,0 )* salary),  '$999,999') )salary    FROM employees inner join departments on employees.department_id = departments.department_id
group by departments.department_id;
COMMIT;

--Q7
select employee_id, first_name , last_name,department_id from employees
where last_name in (
select last_name from employees
group by last_name
having count(last_name)>1)order by last_name;
COMMIT;
--Q8
select employee_id, last_name, first_name, e.department_id ,manager_id

from employees e, departments d

where    e.department_id = d.department_id and

                    e.department_id = 70 or e.department_id=  60 and  e.manager_id != d.manager_id;
COMMIT;


----Q9
SET SERVEROUTPUT ON
declare
l_name varchar2(25):= 'Adams';
sal     number(8,2):=5678;

begin
dbms_output.put_line(l_name ||' ' || TO_CHAR(sal,'$999,999.99'));

end;
/
----Q10
SET SERVEROUTPUT ON
<<outer_b>>
declare
counter integer := 1;
name1 varchar2(30) := 'Wabash';

begin
declare
counter  integer :=99;
begin
dbms_output.put_line( outer_b.counter ||' '|| counter|| ' '|| outer_b.name1);

end;


end  outer_b;
/













