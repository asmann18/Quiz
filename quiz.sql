create database Store
use Store

create table Catagories(
id int primary key identity,
name nvarchar(32) unique not null)

create table Products(
id int primary key identity,
productCode int not null unique,
categoryId int foreign key references Catagories(id))

create table Stock(
id int primary key identity,
productId int foreign key references Products(id),
createdData datetime2 DEFAULT (GETDATE()),
count int not null)


create table Sizes(
id int primary key identity,
letter nvarchar(32),
min int,
max int)

ALTER TABLE Stock
ADD size int



insert into Catagories
values ('T-shirt'),('Jeans'),('Shoes'),('Jacket')

insert into Products
values (1231423,1),(3124325,2),(13243,3),(132114,4)

insert into Stock
values (1,'2023-04-19 19:20:30.2772527',2,49),(2,'2023-04-19 14:20:30.2772527',4,51),(3,'2023-04-19 19:23:20.2772527',14,41)


insert into Sizes
values ('xs',40,45),('s',46,50),('m',51,55)

create view Store
as
select p.productCode 'Product Code',c.name 'Category',st.createdData,st.count,st.size,s.letter   from Stock st
join Products p
on st.productId=p.id
join Catagories c
on p.categoryId=c.id
join Sizes s
on st.size>=s.min and st.size<=s.max


select*from Store
where letter='xs'




create procedure getProductBySizes @size nvarchar(3)
as
select*from Store
where letter=@size
go

exec getProductBySizes @size='xs'



create function getProductsCountByCategory @categoryID int
Returns int result
begin
select COUNT(Stock.count) from Stock
join Products
on Stock.productId=Products.id
where Products.categoryId=@categoryID
return result
end


CREATE TRIGGER selectProduct
ON Products
AFTER INSERT
AS
BEGIN
	SELECT * FROM Store
END




--9
select*from Store

