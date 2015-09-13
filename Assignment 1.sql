-- 7a
select ssn, fname, lname
from employee, department
where dno=dnumber and not (dname='Administration' or dname='Headquarters');

-- 7b
select ssn, fname, lname
from employee
join department on dno=dnumber
where not (dname='Administration' or dname='Headquarters');

-- 7c
select ssn, fname, lname
from employee, department
where dno=dnumber and dnumber not in (select dnumber from department where dname='Administration' or dname='Headquarters');

-- 7d
select ssn, fname, lname
from employee, department
where dno=dnumber and dnumber = any (select dnumber from department where dname<>'Administration' and dname<>'Headquarters');

-- 7e
Select ssn, fname, lname
From employee
Where not exists
    (select *
     from department
     where dno=dnumber
     and (dname='Administration' or dname='Headquarters'));

-- 7f
select ssn, fname, lname
from employee, (select * from department where dname not in ('Administration', 'Headquarters'))
where dno=dnumber;

-- 8
select ssn, lname, hours
from employee, works_on, project
where ssn=essn and pno=pnumber and pname='ProductY' and hours >= 10
order by ssn;

-- 9a
(select distinct ssn, address
from employee, works_on, project
where ssn=essn and pno=pnumber)
MINUS
(select ssn, address
from employee, works_on, project
where ssn=essn and pno=pnumber and pname='ProductY');

-- 9b
select distinct ssn, address
from employee, works_on, project
where ssn=essn and pno=pnumber and pname<>'ProductY';

-- 10
select avg(salary), median(salary), stats_mode(salary)
from employee
where sex='M';

-- 11
select dname, dnumber, avg(salary), median(salary), stats_mode(salary)
from employee, department
where dno=dnumber and sex='M'
group by dname, dnumber;

-- 12
select superssn, count(*)
from employee
group by superssn
having count(*) < 3;

-- 13
select e.fname, e.lname, d.bday Dep_Bday
from employee e
outer join dependent d
on e.ssn=d.essn;

-- 14
select distinct *
from (
select listagg(dependent_name, '; ') within group (order by essn) over (partition by essn) as "Siblings"
  from dependent
  where relationship in ('Son', 'Daughter'));

-- 15
(select ssn, address, pno
from employee, works_on, project
where ssn=essn and pno=pnumber)
MINUS
(select ssn, address, pno
from employee, works_on, project
where ssn=essn and pno=pnumber and pname='ProductY');

-- 16
select avg(salary), median(salary)
from department, employee
where dno=dnumber and (select median(salary) from employee where dnumber=dno) > 31000
group by dnumber;

-- 17
select fname, lname, dependent_name SPOUSE
from employee
outer join dependent
on ssn=essn
where relationship='Spouse';

-- 18
select ssn, (select count(*) from dependent where ssn=essn) as count
from   employee
where  (select count(*) from dependent where ssn=essn   ) > (select avg(count(*)) from dependent group by essn);