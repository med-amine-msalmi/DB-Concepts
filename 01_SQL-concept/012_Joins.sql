select c.id, c.name, o.amount
from customers c
join orders o
on c.id = o.customer_id;
----------------------
select e.first_name, e.last_name , d.name deptName
from employees e join departments d
on e.department_id = d.id
where d.name = 'MIS';
-------------------------------
select e.first_name, e.last_name , d.name deptName, c.name countryName
from employees e join departments d
on e.department_id = d.id
join countries c
on e.country_id = c.id
where d.name = 'MIS';
--------------------------
select e.first_name, e.last_name , d.name deptName, c.name countryName
from employees e join departments d
on e.department_id = d.id
join countries c
on e.country_id = c.id
where c.name = 'USA';