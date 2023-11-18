Create table Employees
(
 ID int primary key identity,
 FirstName nvarchar(50),
 LastName nvarchar(50),
 Gender nvarchar(50),
 Salary int
)
GO

Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)
Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
GO

select * from Employees order by Salary desc
/*
select max(Salary) from Employees as Salary
where Salary < (select max(Salary) from Employees);
*/
/*
select top 1 salary FROM
(select distinct top 2 salary
from Employees 
order by salary DESC
)
result
order by salary
*/

with result as 
(
select Salary, DENSE_RANK() over (order by salary DESC) as denserank
FROM Employees
)
select top 1 Salary 
from result
where result.denserank = 3


with result as 
(
select Salary, ROW_NUMBER() over (order by salary DESC) as rownumber
FROM Employees
)
select top 1 Salary 
from result
where result.rownumber = 2



/*
To find the highest salary it is straight forward. We can simply use the Max() function as shown below.
Select Max(Salary) from Employees

To get the second highest salary use a sub query along with Max() function as shown below.
Select Max(Salary) from Employees where Salary [ (Select Max(Salary) from Employees)

To find nth highest salary using Sub-Query
SELECT TOP 1 SALARY
FROM (
      SELECT DISTINCT TOP N SALARY
      FROM EMPLOYEES
      ORDER BY SALARY DESC
      ) RESULT
ORDER BY SALARY

To find nth highest salary using CTE
WITH RESULT AS
(
    SELECT SALARY,
           DENSE_RANK() OVER (ORDER BY SALARY DESC) AS DENSERANK
    FROM EMPLOYEES
)
SELECT TOP 1 SALARY
FROM RESULT
WHERE DENSERANK = N

To find 2nd highest salary we can use any of the above queries. Simple replace N with 2. 

Similarly, to find 3rd highest salary, simple replace N with 3. 

Please Note: On many of the websites, you may have seen that, the following query can be used to get the nth highest salary. The below query will only work if there are no duplicates.
WITH RESULT AS
(
    SELECT SALARY,
           ROW_NUMBER() OVER (ORDER BY SALARY DESC) AS ROWNUMBER
    FROM EMPLOYEES
)
SELECT SALARY
FROM RESULT
WHERE ROWNUMBER = 3
