use master
restore database EmployeesBak
from disk='C:\Backup\EmployeesDBbak'

--Get all employees that have manager along with Manager's name.
select Employees.EmployeeID,ManagerId,Name,Salary from Employees
where ManagerID is not null;

--Get all employees that have manager or does not have manager along with 
--Manager's name, incase no manager name show null
select Employees.EmployeeID,Employees.ManagerID,Employees.Name,E2.Name as ManagerName from Employees 
left join Employees as E2  on E2.EmployeeID=Employees.ManagerID;

--Get all employees that have manager or does not have manager along with 
--Manager's name, incase no manager name show null

select Employees.EmployeeID,Employees.ManagerID,Employees.Name,
case 
   when Employees.ManagerID is null then Employees.Name
  else E2.Name
end as ManagerName
from Employees left join Employees as E2  on E2.EmployeeID=Employees.ManagerID

--Get all employees that have managed by Mohammed 
SELECT        Employees.Name, Employees.ManagerID, Employees.Salary, Managers.Name AS ManagerName
FROM            Employees INNER JOIN
                         Employees AS Managers ON Employees.ManagerID = Managers.EmployeeID
where Managers.Name='Mohammed'