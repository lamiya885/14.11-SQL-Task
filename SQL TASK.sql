create database LibraryDB
use LibraryDB



	create table Authors
	(
	ID int primary key identity,
	Name nvarchar(50),
	Surname nvarchar(50)
	)

	insert into Authors
	values('Ezize','Ceferzade'),
	('Gulzar','Ibrahimova'),
	('Xanim ','Aydin'),
	('Solmaz','Amanova')




CREATE TABLE Books
(
ID int primary key identity,
Name nvarchar(100) 
check(len(Name)>=2 ),
PageCount int 
check (PageCount >=10),

AuthorID int foreign key references Authors(ID) 
)

insert into Books
values('Vetene Qayit',272,1),
('Baki-1501',376,1),
('Yagis olmaq isteyirem',120,3),
('Irs',80,4)









create view use_GetBookAuthor
as
select B.ID,B.Name,B.PageCount,Concat(a.Name,a.Surname) as Fullname from Books as B
join Authors as A
on B.AuthorID=A.ID

select *from use_GetBookAuthor



create view use_GetAuthorSearch
as
select A.ID ,Concat(A.Name,'.',A.Surname) as FullName,count(B.ID) as BooksCount ,
max(B.PageCount) as MaxPageCount from Authors as A
join Books as B
on B.AuthorID=A.ID
group by A.ID,A.Name ,A.Surname
 

 
select *from use_GetAuthorSearch









create  procedure usp_AuthorsBooks @Search nvarchar(50)  
as
select B.ID,B.name,B.PageCount,CONCAT(A.name,A.SurName) as AuthorfullName  from Authors AS A
join Books AS B
on a.ID=b.AuthorID
Where B.Name=@Search OR CONCAT(A.name,A.SurName)=@Search

exec  usp_AuthorsBooks 'SolmazAmanova'

drop procedure usp_AuthorsBooks



create procedure usp_AuthorInsert @name nvarchar(50),@Surname nvarchar(50)
as
insert into Authors
values(@name,@Surname)


exec usp_AuthorInsert 'Lamiya','Hasanzada'

 create procedure usp_AuthorUpDate  @ID int,@name nvarchar(50),@Surname nvarchar(50)
as
 update  Authors
set Name=@name,Surname=@Surname
where ID=@ID
select*from Authors

exec usp_AuthorUpDate 2 ,'Lamiya','Hasanzada'



create procedure usp_AuthorDelete @name nvarchar(50)
as 
delete from Authors
 where Name=@name

 exec usp_AuthorDelete @name='Lamiya'

