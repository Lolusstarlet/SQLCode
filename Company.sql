
OVERVIEW
Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy:
-- Founder -> Lead Manager -> Senior Manager -> Manager -> Employee
-- Given the tables below, write a query to print the company_code, founder name, total number of lead managers,
-- total number of senior managers, total number of managers, and total number of employees. Order your output by 
-- ascending company_code.
-- Note:
-- The tables may contain duplicate records
-- The company code is string, so the sorting should be numeric. For example, if the company_codes are C_1, C_2, and C_10, then the ascdening company codes will be C_1, C_10 and C_2.

-- The following tables contain company data:


DATABASE QUERY
-- Company: The company_code is the code of the company and founder is the founder of the company
-- DROP TABLE IF EXISTS task.locations
CREATE TABLE Company (
    company_code varchar(100),
	founder varchar(100)
);

-- Lead_Manager: The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company.
-- DROP TABLE IF EXISTS task.locations
CREATE TABLE Lead_Manager (
  lead_manager_code varchar(100),
  company_code varchar(100) NOT NULL
);

-- Senior_Manager: The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.
-- DROP TABLE IF EXISTS task.transactions
CREATE TABLE Senior_Manager (
  senior_manager_code varchar(100),
  lead_manager_code varchar(100),
  company_code varchar(100)
);

-- Manager: The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company
-- DROP TABLE IF EXISTS task.vehicles
CREATE TABLE Manager (
  manager_code varchar(100),
  senior_manager_code varchar(100),
  lead_manager_code varchar(100),
  company_code varchar(100)
);

-- Employee: The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company
-- DROP TABLE IF EXISTS task.drivers
CREATE TABLE Employee (
  employee_code varchar(100),
  manager_code varchar(100),
  senior_manager_code varchar(100),
  lead_manager_code varchar(100),
  company_code varchar(100)
);


INSERT INTO Company 
VALUES ('C1', 'Monika'),
       ('C2', 'Amy');
       
INSERT INTO Lead_Manager 
VALUES ('LM1', 'C1'),
       ('LM2', 'C2');
       
INSERT INTO Senior_Manager 
VALUES ('SM1', 'LM1','C1'),
       ('SM2', 'LM1','C1'),
       ('SM3', 'LM2','C2');
       
INSERT INTO Manager 
VALUES ('M1','SM1', 'LM1','C1'),
       ('M2','SM3', 'LM2','C2'),
       ('M3','SM3', 'LM2','C2');
       
INSERT INTO Employee 
VALUES ('E1','M1','SM1', 'LM1','C1'),
       ('E2','M1','SM1', 'LM1','C1'),
       ('E3','M2','SM3', 'LM2','C2'),
       ('E4','M3','SM3', 'LM2','C2');
       

--Solution:
select c.company_code,
       c.founder,
       count(distinct(lead_manager_code)),
       count(distinct(senior_manager_code)),
       count(distinct(manager_code)),
       count(distinct(employee_code))
from Employee e
left join Company c on e.company_code = c.company_code
group by c.company_code, c.founder
order by c.company_code; 
