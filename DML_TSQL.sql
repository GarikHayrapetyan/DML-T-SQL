create database productsdb;
Go
use productsdb;

create table Products(
    Id int identity primary key,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL 
);

insert Products values('Iphone 7','Apple',1,2000)

insert into Products (ProductCount,ProductName,Manufacturer,Price)
values(2,'Galaxy s9','Samsung',2500) 

select * from Products

insert Products 
values 
('iPhone 6', 'Apple', 3, 36000),
('Galaxy S8', 'Samsung', 2, 46000),
('Galaxy S8 Plus', 'Samsung', 1, 56000)


select Products.ProductName, Products.Price 
from Products;

select Products.ProductName + '('+Products.Manufacturer+')' as [Model name],
Price,
Products.Price*Products.ProductCount as Amount
from Products

select distinct Products.Manufacturer from Products

select Products.ProductName + '('+Products.Manufacturer+')' as [Model name],
Price,
Products.Price*Products.ProductCount As Amount
into ProductSummary
from Products

select * from ProductSummary

exec sp_columns ProductSummary

insert into ProductSummary
select ProductName + ' (' + Manufacturer + ')',
Price,
Products.ProductCount*Price
from Products

drop table ProductSummary


select * from Products
order by Price 

select *, Price*0.2 as Tax
from Products
order by Tax desc


select *
from Products
order by Manufacturer, ProductName 

select * from Products
order by Price

Select top 5 percent * from Products

select * from Products
order by Id
offset 2 rows
fetch next 2 rows only;


select * from Products 
where (Manufacturer = 'Samsung' or ProductCount >1) and Price>2500

select * from Products 
where Manufacturer = 'Samsung' and ProductName <> 'Galaxy S8' or ProductCount >1 and Price>2500

select * from Products where Manufacturer is not null

select * from Products where Price in (1200,2500,46000)
order by Price desc

select Products.ProductName from Products where Price between 1 and 10000

select * from Products
where ProductName like 'Galaxy%'

select * from Products
where ProductName like '%Galaxy%'

select * from Products
where ProductName like '%Galaxy'

select * from Products
where ProductName like 'Galaxy S_'

select * from Products
where ProductName like 'Galaxy S[3-9]'

select * from Products
where ProductName not like 'Galaxy S[3-9]' 

select * from Products
where ProductName like 'Iphone [^1-6]' 

select * from Products
where ProductName like '[A-G]%' 

Update Products
set Price=Price*2

select * from Products

update Products
set Manufacturer = Manufacturer+' Inc.'
where Manufacturer = 'Samsung'


UPDATE Products
SET Manufacturer = 'Apple Inc.'
FROM
(SELECT TOP 2 * FROM Products WHERE Manufacturer='Apple') AS Selected
WHERE Products.Id = Selected.Id

update products
set Manufacturer = 'Samsung Inc.'
from (Select Top 2* from products where Manufacturer='Samsung') as Selected
where Products.Id=Selected.Id

exec sp_columns ProductSummary

create table ProductSummary(
    Id int identity primary key,
    ProductName NVARCHAR(30) NOT NULL,
    Manufacturer NVARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price MONEY NOT NULL
)

insert ProductSummary
select ProductName,Manufacturer,ProductCount,Price
from Products

select * from ProductSummary

delete ProductSummary
from(select * from Products order by Id offset 2 rows fetch next 2 rows only) as Selected
where ProductSummary.Id = Selected.Id

select * from ProductSummary