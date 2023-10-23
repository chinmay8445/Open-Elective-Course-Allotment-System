select name,urn,cpi,branch,choice1,choice2,choice3
from choices
order by cpi desc, timestamp

select * from courses

select * from allotment

drop table allotment


create table allotment
(
name varchar2(200) not null,
urn varchar2(20) primary key,
branch varchar2(100),
choiceno number,
coursename varchar2(100)
)

select * from allotment

truncate table allotment

select * from courses

select sum(intake)-sum(capacity) 
from courses

select * from allotment
where choiceno IS NULL

truncate table courses

select * from choices

select count(*) from choices

select count(*) from allotment


EXECUTE open_allotment

COMMIT