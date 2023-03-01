# Employee-Payroll-Management

This project is coded using bash script to maintain the mothly salary details of an employee that includes earnings and deduction that the employee receive from their respective company. The only purpose in using bash script is to show that this problem can also be implemented by this way. In adddition to that, the data is stored in MySQL databse that is installed inbuild in the kernel.

## Here is the structure of the database.
### Create a database.
```mysql
create database sample;
```
### Use the database.
```mysql
use sample;
```
### Create the table for storing salary details.
```mysql
CREATE TABLE employee_salary_detail (emp_idno int primary key not null,    
                                          emp_name varchar(50),    
                                          emp_dept varchar(50),    
                                          emp_occp varchar(50),
                                          hra decimal(7,2),    
                                          ca decimal(7,2),    
                                          ea decimal(7,2),    
                                          gross_salary decimal(7,2),    
                                          pf decimal(7,2),    
                                          credit decimal(7,2),    
                                          deduction decimal(7,2),    
                                          net_salary decimal(7,2),    
                                          basic_salary decimal(7,2));
```
After creating the table, it is described as follow:
![Screenshot (95)](https://user-images.githubusercontent.com/100774000/222060063-42b851af-ece9-4da6-a3fc-6b3ce5954f9d.png)
