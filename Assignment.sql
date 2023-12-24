#Assignment 1

#1
create database assignment;
use assignment;

#3
create table countries (name char(15), population bigint,capital char(15));
insert into countries values('China',1382,'Beijing'),('India',1326,'Delhi'),('United States',324,'Washington D.C.'),
('Indonesia',260,'Jakarta'),('Brazil',209,'Brasilia'),('Pakistan',193,'Islamabad'),('Nigeria',187,'Abuja'),
('Bangladesh',163,'Dhaka'),('Russia',143,'Moscow'),('Mexico',128,'Mexico City'),('Japan',126,'Tokyo'),('Philippines',102,'Manila'),
('Ethiopia',101,'Addis Ababa'),('Vietnam',94,'Hanoi'),('Egypt',93,'Cairo'),('Germany',81,'Berlin'),('Iran',80,'Tehran'),
('Turkey',79,'Ankara'),('Congo',79,'Kinshasa'),('France',64,'Paris'),('United Kingdom',65,'London'),('Italy',60,'Rome'),
('South Africa',55,'Pretoria'),('Myanmar',54,'Naypyidaw');
select * from countries;
desc countries;
insert into countries values('Australia',200,'Canberra'),('New Zealand',90,'Wellington');
update countries set capital='New Delhi' where name='india';

#4

rename table countries to big_countries;
select * from big_countries;

#5

create table suppliers(supplier_id int primary key,supplier_name char(15),location char(15));
create table product(product_id int primary key,product_name char(25) unique not null,supplier_id int,
foreign key (supplier_id) references suppliers(supplier_id));
create table stock(id int primary key,product_id int, foreign key(product_id) references product(product_id));
alter table product add description char(100);
desc suppliers;

#6

insert into suppliers values(1,'abc','hyderabad');
insert into suppliers values(2,'def','mumbai'),(3,'efg','chennai');
insert into product values(101,'xyz',3);
insert into product values(102,'uvw',2),(103,'pqr',1);
insert into stock values(201,101);
insert into stock values(202,102),(203,103);
select * from suppliers;
select * from product;
select * from stock;

#7

alter table suppliers modify supplier_name char(22) unique not null;
alter table stock add balance_stock int;
desc suppliers;
desc stock;
desc product;
select * from emp;

#8

alter table emp add deptno int;
update emp set deptno=20 where mod(emp_no,2)=0;
update emp set deptno=30 where mod(emp_no,3)=0;
update emp set deptno=40 where mod(emp_no,4)=0;
update emp set deptno=50 where mod(emp_no,5)=0;
update emp set deptno=10 where deptno is null;
desc emp;

#9

create unique index id on emp(emp_no);

#10

create view emp_sal as select emp_no,first_name,last_name,salary from emp order by salary asc;
select * from emp_sal;

# Assignment 2

#1

select * from emp where deptno=10 and  salary>3000;
show tables;
select * from students;
alter table students add grade char(10);
alter table students modify grade char(20);

#2

update students set grade='Distinction' where marks>80;
update students set grade='First Division' where marks between 60 and 80;
update students set grade='Second Division' where marks between 50 and 59;
update students set grade='Third Division' where marks between 40 and 49;
update students set grade='Fail' where marks<40;
select count(*) as First_Division from students where grade='First Division';
select count(*) as Distionction from students where grade='Distinction';

#3

select distinct city, id, state from station where mod(id,2)=0;

#4

select count(city)-count(distinct city) as difference from station;

#5

select distinct city from station where left(city,1) in ('a','e','i','o','u');
select distinct city from station where left(city,1) in ('a','e','i','o','u') and right(city,1) in ('a','e','i','o','u');
select distinct city from station where left(city,1) not in ('a','e','i','o','u');
select distinct city from station where left(city,1) not in ('a','e','i','o','u') or right(city,1) not in ('a','e','i','o','u');

#6

select * from emp where timestampdiff(month,hire_date,now()) < 36 having salary>2000 order by salary desc;

#7

select deptno,sum(salary) as total_salary from employee group by deptno;

#8

select count(name) from city where population>100000;

#9
select * from city;
select sum(population) from city where district='california';

#10
select countrycode,district,avg(population) from city group by district;

#11
select o.ordernumber,o.status,o.customernumber,c.customername,o.comments from orders o left join customers c on (o.customernumber=c.customernumber) 
where o.status='Disputed';


#Assignment 3

#Q1

delimiter //
CREATE PROCEDURE `order_status1`(year1 int,month1 int)
BEGIN
select orderNumber,orderDate,status from orders where year(orderdate) = year1 and month(orderdate)=month1;
END //
delimiter;

call order_status1(2005,11);

#2

show tables;
select * from cancellations;

create table cancellations(id int primary key auto_increment,customernumber int, foreign key (customernumber) references customers(customerNumber),
ordernumber int, foreign key(ordernumber) references orders(ordernumber), comments text);

show tables;
select * from orders;

desc cancellations;
call cancellations1();

select * from cancellations;
select * from orders;


select * from cancellations;

delimiter //
create procedure cancellations1()
BEGIN
insert into cancellations( customernumber,ordernumber,comments) 
select customernumber,ordernumber,comments from orders where status='cancelled';
END //
delimiter ;


call cancellations1();

select * from orders where status='cancelled'; 

select * from customers;
select * from payments;


#Q3

delimiter //
CREATE FUNCTION `purchase_check`(num int) RETURNS char(20) CHARSET utf8mb4
BEGIN
declare status_check char(20);
declare total int;
set status_check = (select sum(amount) from payments where customernumber=num);
if total<25000 then 
set status_check = 'Silver';
elseif total between 25000 and 50000 then 
set status_check = 'Gold';
else set status_check='Platinum';
end if;
RETURN status_check;
END //
delimiter ;

select assignment.purchase_check(109);

select customernumber,customername,purchase_check(109) from customers;



select * from movies;
select * from rentals;

#4

create trigger on_delete_trigger_rentals
after delete on movies for each row 
delete from rentals where old.id=rentals.memid;
delete from movies where id=3;

create trigger on_update_cascade_rentals
after update on movies for each row
insert into rentals(memid,first_name,last_name,movieid) values (new.id,NULL,NULL,NULL);
update movies set id=3 where id=10;



select * from employee;

#5

SELECT fname,salary FROM Employee  ORDER BY Salary DESC LIMIT 2,1;

#6

select rank() over(order by salary desc) as rank_value, empid,fname,lname,salary from employee;













