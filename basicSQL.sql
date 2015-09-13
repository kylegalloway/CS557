-- Select SSN of employees who work in the research department
Select ssn
From employee
Where dno in
    (Select dnumber
     From department
     Where dname='Research');

-- Select SSN of employees who work in departments located in Houston
Select ssn
From employee
Where dno in
    (Select dnumber
     From dept_locations
     Where dlocation='Houston');

-- Select SSN of employees who work in departments located in Houston using exists
Select ssn
From employees
Where exists
    (Select *
     From dept_locations
     Where dlocation='Houston'
     And dno=dnumber);

-- For every project located in 'Stafford' list the project number, the controlling department number and department manager's last name, address and birthdate.
Select pnumber, dnum, lname, address, bdate
From employee, department, project
Where plocation='Stafford' And
dnum=dnumber And mgrssn=ssn;

-- For each employ print their last name and their supervisor's last name
Select E.lname, S.lname
From employee E, employee S
Where E.superssn=S.ssn;

--For each project on which more than two employees work, retrieve the project name, and the number of employees who work on that project.
Select pname, COUNT(*)
From Project, Works_on
Where pnumber =pno
Group By pname
Having COUNT(*) > 2

-- List all employees who don’t work on a project:
Select ssn from employee
Minus
Select essn from works_on

-- Select employees who do not work on project 20

select essn
from works_on
where pno<>20;

select distinct essn
from works_on
where essn not in (select essn from works_on where pno=20);

-- Select employees who do not work on project 20 using minus

Select essn from works_on
Minus
Select essn from works_on
Where pno=20;

-- List all project names for projects that is worked on by an employee whose last name is Smith or has a Smith as a manager of the department that controls the project
Select pname
From employee, works_on, project
Where pno=pnumber and ssn=essn and lname='Smith'
Union
select pname
from department, employee, project
where dnum=dnumber and mgrssn=ssn and lname='Smith';

-- Misc.
SELECT ssn
FROM employee
WHERE dno in
(SELECT dnumber
 FROM department
 WHERE dname='Research');

SELECT ssn
FROM employee
WHERE dno in
(SELECT dnumber
 FROM dept_locations
 WHERE dlocation='Houston');

SELECT ssn
FROM employees
WHERE exists
(SELECT *
 FROM dept_locations
 WHERE dlocation='Houston'
 AND dno=dnumber)

SELECT pnumber, dnum, lname, address, bdate
FROM employee, department, project
WHERE plocation='Stafford' AND
dnum=dnumber AND mgrssn=ssn;

SELECT E.lname, S.lname
FROM employee E, employee S
WHERE E.superssn=S.ssn;