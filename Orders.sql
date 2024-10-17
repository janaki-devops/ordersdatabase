Create database ORDERS;

use ORDERS;

Create table Products
(ProductId int not null,
ProductName varchar(50) not null,
Category varchar(50) not null,
SupplierId char(50) not null,
Price decimal(4,2),
constraint 
pk_Products
primary key(ProductId),
Foreign Key (SupplierID) References Supplier(SupplierId));

Create table Orders
(OrderId int  not null,
CustomerId char(50) not null,
Quantity int not null,
OrderDATE date,
constraint 
pk_Order
primary key(OrderId),
Foreign Key (CustomerID) References customers(CustomerId));


create table Customers
(CustomerId char(50) not null,
CustomerName varchar(50) not null,
Address varchar(60) not null,
city varchar(15) not null,
Postcode varchar(10) not null,
Country varchar(10) not null,
Phone varchar(24) not null,
constraint 
pk_Customer
primary key(customerId));

Create table supplier
(SupplierId char(50) not null,
Name varchar(50) not null,
City varchar(20) not null,
Province varchar(50) not null,
constraint 
pk_Supplier
primary key(SupplierId));

Create table Shippers
(ShippersId char(50) not null,
CompanyName varchar(50), 
constraint 
pk_Shipper
primary key(SupplierId));


insert into orders.Products
(ProductId, ProductName, Category, SupplierId, Price)
values
('PR01', 'Drawstring denim shorts', 'Clothing', 'S1', 8.00),
('PR02', 'Oven tray', 'Cooking & Dining', 'S3', 6.00),
('PR03', 'Welcome door mat', 'Household','S1', 12.00),
('PR04', 'Nivea LipBalm', 'Health & Beauty', 'S4', 2.30),
('PR05', 'Kodak film camera', 'electronics', 'S6', 20.00),
('PR06', 'KG Yoga mat', 'fitness', 'S3', 25.00);
select * from orders.products;


alter table orders change column  shipvia  ship_via varchar(10);

alter table Orders add OrderDate date;

set sql_safe_updates = 0;

update supplier
set supplierid = 'S6'
where  Name = 'HOOPER';

select * from orders.Supplier;


insert into orders
(OrderId, CustomerId, Quantity, OrderDate)
values
('OR01', 'C1', 50, '2022-04-15'),
('OR02', 'C3', 35, '2022-04-28'),
('OR03', 'C3', 10, '2022-05-05'),
('OR04', 'C4', 55, '2022-05-05'),
('OR05', 'C5', 09, '2022-05-15'),
('OR06', 'C4', 12, '2022-06-02'),
('OR07', 'C6', 75, '2023-01-03');
ALTER TABLE orders
modify COLUMN OrderID char(20);


select * from orders.Orders;

insert into Customers
(CustomerId, CustomerName, Address, City, Postcode, Country, Phone)
values
('C1', 'Paul', '1 Chapel hill', 'Bath', 'BH4 5TF', 'UK', '555-0347'),
('C2', 'Emily', '21 Mary Street', 'Aberdeen', 'AB3 4RT', 'UK', '555-0000'),
('C3', 'Daniel', '10 My Village', 'Bath', 'BH1 1AA', 'UK', '555-0345'),
('C4', 'Oliver', '05 Bagshot Road', 'Edinburgh', 'EL1 5SD', 'UK', '555-9889'),
('C5', 'Neil', '25 High Street', 'York', 'YO2 2ER', 'UK', '555-1235'),
('C6', 'Oliver', '40 Elton Road', 'Cardiff', 'CF9 9UH', 'UK', '555-2188');

select * from orders.Customers;

insert into Supplier
(SupplierId, Name, City, Province)
values
('S1', 'Henry', 'Edmonton', 'Alberta'),
('S2', 'Nicole', 'Brisbane', 'Queensland'),
('S3', 'Jacob', 'Puli', 'Taiwan'),
('S4', 'Jack', 'Edmonton', 'Alberta'),
('S5', 'Peter', 'Butterworth', 'Penang'),
('S6', 'Hooper', 'Douglaston', 'Queensland');

select * from orders.supplier;
                                                                                         V                                                                                                                                 VVVVVVVVVVVVVVVVVVVVVVVBBBBBBBBBBBBBBBBBBBBBBB                       NBNNM                      MN 
insert into Shippers
(ShippersId, CompanyName, Shipvia)
values
('SH1', 'EasyShipping', 'ESY 2NW'),
('SH2', 'DeliveryWorld','DWD ENM'),
('SH3', 'FastmoreLogistics', 'FSL FTT'),
('SH4', 'OceanfrontShipping', 'OFS GNM'),
('SH5', 'Sharkey', 'SHY SHY'),
('SH6', 'CargoExpress', 'CAR EXP');


select * from orders.shippers;

ALTER TABLE Shippers
add COLUMN Shipvia char(20);

JOINS:

select 
products.supplierid, supplier.supplierid
from
products
left join
supplier
on products.supplierid = supplier.supplierid;

select 
products.supplierid, supplier.supplierid
from
products
right join
supplier
on products.supplierid = supplier.supplierid;

select 
products.supplierid, supplier.supplierid
from
products
inner join
supplier
on products.supplierid = supplier.supplierid;

select productname as 'product', name as 'supplier'
from products
inner join
supplier
on products.supplierid = supplier.supplierid;

select 
orders.CustomerId, customers.customerId
from
orders
left join
customers
on orders.CustomerId = customers.customerId;

select 
orders.CustomerId, customers.customerId
from
orders
right join
customers
on orders.CustomerId = customers.customerId;

select 
orders.CustomerId, customers.customerId
from
orders
inner join
customers
on orders.CustomerId = customers.customerId;

select orderid as 'Id', quantity as 'qty', orderdate as 'date'
from orders
right join
customers
on orders.customerid = customers.customerid;

select orderid as 'ORId', quantity as 'qty', orderdate as 'date'
from orders
union all
select customerId as 'CId', customername as 'Name', city as 'city'
from customers;

QUERY:

select CustomerId, Customername, Address, city
from customers
where customerid in(
select orders.customerid
from orders.orders
where orderdate = '2022-04-15'
);

SELECT CustomerName, address, postcode
FROM Customers
WHERE CustomerID not in
(  SELECT CustomerID
FROM Orders
WHERE quantity > 20
)

use ORDERS;

select Productname, category
from products
where
price != 20;


GROUP BY:

Find the total quantity in orders

select customerid, sum(quantity) as 'Total Quantity'
from orders.orders
group by customerid;


select province, count(*)
from supplier
where province = 'alberta'
group by province;

select customername, city, address, phone 
FROM orders.customers
ORDER BY phone;

VIEWS:

create view vw_orders_db
As
SELECT orderid, customerid, quantity, orderdate
from orders
where orderdate like '2022-05-05';
select * from vw_orders_db;

select * from orders;

insert INTO vw_orders_db(orderid, customerid, quantity, orderdate)
VALUES
('OR07','C6',75,'2023-01-03');

CREATE OR REPLACE VIEW vw_customers_db
AS
SELECT CustomerId, CustomerName, Address, City, Postcode, Country, Phone
from customers
where customername like 'oliver'
with check option;


INSERT INTO vw_customers_db
(CustomerId, CustomerName, Address, City, Postcode, Country, Phone)
VALUES
('C7', 'Jacky', '10 Park view close', 'Cardiff', 'CF9 MM3', 'UK', '555-0707');

CREATE  VIEW vw_Shippers_db
AS
SELECT ShippersId, Companyname
from shippers
where Companyname like '%g';

STORED PROCEDURE:

Delimiter //
create procedure shippers()
begin
SELECT ShippersId, Companyname
from shippers
where Companyname like '%g';
end //
delimiter ;

call shippers;

Delimiter //
create procedure product_SupplierId()
begin
select products.supplierid, supplier.supplierid
from
products
left join
supplier
on products.supplierid = supplier.supplierid
WHERE supplier.Name IN
(SELECT Name
FROM supplier
WHERE City = 'Edmonton');
end //
delimiter ;

call product_SupplierId

STORED FUNCTION:
DELIMITER //
CREATE FUNCTION ShippingCharges(Quantity int)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
DECLARE ShippingCharges VARCHAR(20);
IF Quantity > 35 THEN
	SET ShippingCharges = 'Free Delivery';
ELSEIF Quantity = 35  THEN
	SET ShippingCharges = '10%';
ELSEIF Quantity < 35  THEN
	SET ShippingCharges = '20%';
END IF;
RETURN (ShippingCharges);
END // 
DELIMITER ;

TRIGGER:

DELIMITER //
create trigger bfr_delete before delete
on products for each row
Begin signal sqlstate '45000' set message_text = 'Not Allowed';
END // 




delete from shippers where shippersid = 'SH7';




alter table shippers
add constraint
unique key (shipvia);

alter table orders
add constraint 
Foreign Key (ship_via) References shippers(shipvia);

select * from orders;
select * from shippers;

use orders;


insert into shippers(shippersid, companyname, shipvia)
values
('SH7', 'CargoExpress', 'CAR EXP');
