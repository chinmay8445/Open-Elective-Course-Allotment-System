create table choices
(
TIMESTAMP INT,
EMAIL varchar(100) not null,
NAME varchar(200) not null,
URN varchar(20) primary key,
CPI DECIMAL(2,2) not null CHECK (CPI<=10), 
BRANCH varchar(100) not null,
CHOICE_1 varchar(100),
CHOICE_2 varchar(100),
CHOICE_3 varchar(100)
)

create table courses
(
COURSE varchar(100) primary key,
INTAKE INT NULL,
CAPACITY INT
)

create table allotment
(
name varchar2(200) not null,
urn varchar2(20),
branch varchar2(100),
choiceno number,
coursename varchar2(100)
)

drop table allotment

insert into courses values ('Operations Research',150,150);

insert into courses values ('Engineering Tribology',60,60);

insert into courses values ('Process Modeling and Simulation',60,60);

insert into courses values ('Electrical Wiring Harnessing',75,75);

insert into courses values ('Internet of Things',75,75);

insert into courses values ('Lighter Than Air Systems',75,75);

insert into courses values ('Electrical Economics and Energy Audit',75,75);


insert into courses values ('Non-Destructive Testing',75,75);

insert into courses values ('Cyber Laws and Ethical Hacking',75,75);

insert into courses values ('Industrial Management and Operation Research',150,150);


select * from courses

select * from allotment

select count(*) from choices




commit;





insert into courses values ('Operations Research',1,1);

insert into courses values ('Engineering Tribology',5,5);

insert into courses values ('Process Modeling and Simulation',3,3);

insert into courses values ('Internet of Things',2,2);



create table unalloted
(
NAME varchar(200) not null,
URN varchar(20),
BRANCH varchar(100),
COURSENAME varchar(100)
)