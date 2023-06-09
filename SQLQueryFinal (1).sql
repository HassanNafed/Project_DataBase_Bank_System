CREATE DATABASE BankOfTheSystem;

 

CREATE TABLE Bank
(
   code varchar(10),
   B_address varchar(20) not null,
   B_name varchar(20) not null,
   primary key(code)
);
CREATE TABLE branches
(
   branch_num varchar(15) not null,
   b_address varchar(20) not null,
   b_code varchar(10) not null,
   primary key(branch_num),
   foreign key(b_code) references Bank(code)
);

CREATE TABLE Loanes
(
   L_num varchar(15) ,
   L_type varchar(15) not null,
   ammount varchar(10) not null,
   b_num varchar(15) ,
   primary key(L_num ),
   foreign key(b_num) references branches(branch_num)
);
CREATE TABLE Employess
(
   E_ID varchar(20) not null,
  E_num varchar(15),
   E_name varchar(15) not null,
   b_num varchar(15) ,
   primary key(E_ID),
   foreign key(b_num) references branches(branch_num)
);
CREATE TABLE Customers
(
   C_address varchar(20) not null,
   SSN varchar(15),
   C_name varchar(15) not null,
   C_phone varchar(15) not null,
    E_ID varchar(20) not null,
   primary key(SSN),
   foreign key( E_ID) references Employess(E_ID)
);
CREATE TABLE Accountes
(
   Account_num int,
   Account_balance varchar(10) not null,
   Account_type varchar(10) not null,
   Account_b_num varchar(15) not null,
   primary key(Account_num),
   foreign key(Account_b_num) references branches(branch_num)
);
CREATE TABLE Take_a
(
   CSSN varchar(15),
   L_num varchar(15) ,
   primary key(CSSN,L_num),
   foreign key(L_num) references Loanes(L_num),
   foreign key(CSSN) references Customers(SSN)
);
CREATE TABLE have_a
(
    Account_num int,
    SSN varchar(15),
   primary key(Account_num,SSN),
   foreign key(Account_num) references Accountes(Account_num),
   foreign key(SSN) references Customers(SSN)
);




INSERT INTO Customers(C_address,SSN , C_name, C_phone,E_ID)
VALUES('JALANDHAR', '222','PUNJAB', '1996-09-04','20002'),
( 'HARPREET','333','ahmed' ,'1996-10-31','20003')

INSERT INTO Employess(E_ID,E_num,E_name,  b_num)
VALUES('20001', '1','ali', '1221'),
( '20002','2','ashraf' ,'1232')

INSERT INTO Bank(code ,  B_address , B_name  )
VALUES('1-22', 'CAIRO', 'egBank'),
( '1-23','CAIRO' ,'frBank')

INSERT INTO branches(branch_num  , b_address,  b_code  )
VALUES('1221', 'doke', '1-22'),
( '1232','ataba' ,'1-23')

INSERT INTO  Loanes(L_num  , L_type , ammount,  b_num )
VALUES('120999', 'cash','10000$', '1221'),
( '120888','credit','20000$' ,'1232')

INSERT INTO Accountes( Account_b_num  ,Account_balance , Account_num,  Account_type )
VALUES('1221', '3','1234', 'ASD'),
( '1232','3','3221' ,'ABS')



select branch_num,b_address
from branches b join Accountes a
on b.branch_num=a.Account_b_num 
where Account_num not in(select Account_num from Accountes ) ;



select branch_num,b_address
from branches b join Employess e
on b.branch_num=e.b_num
where E_num not in(select
E_num from Employess );

select E_ID ,E_name
from Employess e join branches b
on e.b_num=b.branch_num join Loanes l
on b.branch_num=l.b_num
where L_num=(select Cont(L_num)
                          from Loanes);


select SSN,C_name,C_phone,C_address
from Customers c join Take_a t
on c.SSN=t.CSSN
where L_num=(select max(L_num)
                          from Loanes);



select *
from Customers c join Take_a t
on c.SSN=t.CSSN
where L_num not in (select L_num
from Take_a);




select SSN,C_name,C_phone,C_address,E_num
from Customers c join Employess e
on c.E_ID=e.E_ID;
