@C:\Users\bhala\Downloads\Oracle_sample_crt_employees_Countires_script_edited.sql;
---Nikhil bhalala
--csc352
--q1)
DROP TRIGGER Dept_Del  ;
drop table  Dept_log;
CREATE TABLE      Dept_log(
   Updated_Date	DATE default SYSDATE,
   Updated_By	Varchar2 (15) default USER,
   Action         Varchar2 (30)
);
CREATE OR REPLACE TRIGGER Dept_Del
AFTER DELETE ON Departments
BEGIN
INSERT INTO Dept_log (Updated_date, Updated_By, Action)
VALUES (SYSDATE, User, 'Table Changed');
END Dept_Del;

DELETE departments where department_id = 150;

DELETE departments where department_id > 249;
rollback;
--select *from departments--;
--select * from dept_log;


--q2)
DROP TRIGGER Dept_Del_Row;
DROP table Dept_Del_log;
CREATE TABLE Dept_Del_log (
   Old_Deptno     number (4),
   OLD_Deptname   Varchar2 (30),
   OLD_MgrID      number (6),
   OLD_LocID      number (4),
   Updated_Date	DATE,
   Updated_By	Varchar2 (15),
   Action         Varchar2 (30)
);
CREATE OR REPLACE TRIGGER Dept_Del_Row
AFTER  DELETE   ON departments
FOR EACH ROW
BEGIN
   INSERT INTO Dept_Del_log VALUES
	(:old.department_id, :OLD.department_name, :old.manager_id, :old.location_Id, Sysdate, user, 'tabel changed');	
END Dept_Del_Row;
DELETE departments where department_id = 150;

DELETE departments where department_id > 249;

--select * from Dept_Del_log;
 --rollback;
 
 --Q3)
DROP TRIGGER Dept_Del_Row;
DROP table Dept_Access_log;
CREATE TABLE      Dept_Access_log(
   Deptno         number (4),
   OLD_Deptname   Varchar2 (30),
   NEW_Deptname   Varchar2 (30),
   OLD_MgrID      number (6),
   NEW_MgrID      number (6),
   OLD_LocID      number (4),
   NEW_LocID      number (4),
   Updated_Date	DATE,
   Updated_By	Varchar2 (15),
   Action         Varchar2 (30)
);
CREATE OR REPLACE TRIGGER Change_Dept
AFTER INSERT OR DELETE OR UPDATE OF manager_id, location_Id ON departments
 FOR EACH ROW
 BEGIN
   IF INSERTING THEN
	INSERT INTO Dept_Access_log  VALUES
      (:new.department_id, null,:new.department_name, 0,:new.manager_id, 0, :new.location_Id, Sysdate, user, 'table changed');
   ELSIF UPDATING('manager_id ') THEN
	INSERT INTO Dept_Access_log  VALUES
	(:old.department_id, :OLD.department_name , null, :old.manager_id,:new.manager_id, :old.location_Id, null, Sysdate, user, 'UPDATING_manager_id');	
   ELSIF UPDATING('location_Id') THEN
      INSERT INTO Dept_Access_log  VALUES
	(:old.department_id, :OLD.department_name,null, :old.manager_id,null, :old.location_Id, :new.location_id, Sysdate, user, 'UPDATING_location_id');
    ELSIF DELETING THEN
	INSERT INTO Dept_Access_log  VALUES 
      (:old.department_id, :OLD.department_name ,null, :old.manager_id,null, :old.location_Id,null, Sysdate, user, 'table changed');
   ELSE	
	DBMS_OUTPUT.PUT_LINE('something goes wrong');
   END IF;
 END Change_Dept;
 
Column OLD_Deptname format A10
Column NEW_Deptname format A10

Select * from departments;
SELECT * from Dept_Access_log ;

INSERT INTO departments VALUES (911, 'DeleteMe', 105, 1700);

UPDATE departments set manager_id = 108   WHERE department_id = 911;
UPDATE departments set location_id = 1400 WHERE department_id = 911;

DELETE departments where department_id = 911;
--select * from departments;
--select*from dept_access_log;
--rollback;


--q4)
drop PACKAGE  pkg_func;
drop PACKAGE BODY pkg_func;
CREATE OR REPLACE PACKAGE pkg_func
IS 
    FUNCTION Emp_Sal 
     ( emp_id	number)
       RETURN number;
    FUNCTION Emp_Sal 
     ( emp_mail	employees.email%TYPE)
       RETURN number;      
       
END pkg_func;
/
CREATE OR REPLACE PACKAGE BODY pkg_func
is	 
   FUNCTION Emp_Sal 
     ( emp_id	number)
       RETURN number
      IS
       ret    number (9,2); 	
   BEGIN
    SELECT salary  into ret
    FROM   employees
    WHERE  employee_id = emp_id ;
    RETURN ret;
   END Emp_Sal ;

   FUNCTION Emp_Sal 
     ( emp_mail	employees.email%TYPE)
       RETURN number
      IS
       ret    number (9,2); 	
   BEGIN
    SELECT salary  into ret
    FROM   employees
    WHERE  email = emp_mail ;
    RETURN ret;
   END Emp_Sal ; 
end pkg_func;
/
DECLARE
local_variable_al employees.employee_id%type :=  Pkg_func.Emp_Sal ( 100 ) ;
local_variable_a2 employees.email%TYPE:=  Pkg_func.Emp_Sal ( 'SKING'  ) ;
begin
dbms_output.put_line(local_variable_al);
dbms_output.put_line(local_variable_a2);
END;
/

--rollback;


