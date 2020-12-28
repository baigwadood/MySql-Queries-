create schema Sailor_Company;

create table sailor
( sid int not null,
  sname varchar(20),
  rating int,
  age int,
  primary key (sid));
  
create table boat
( bid int not null,
  bname varchar(20),
  color varchar(20),
  primary key (bid));
  
  create table reserve 
( sid int,
  bid int,
  day varchar(10),
  primary key (sid,bid),
  foreign key reserve_sid(sid)
	references sailor(sid)
    on update cascade,
  foreign key reserve_bid(bid)
	references boat(bid)
    on update cascade); 

insert into boat
values 
		(101,'interlake','blue'),
        (102,'interlake','red'),
        (103,'clipper','green'),
        (104,'marine','red');

alter table sailor
modify column age float;

insert into sailor
values
		(22,'Dustin',7,45.0),
        (29,'brutus',1,33.0),
        (31,'lubber',8,55.5),
        (32,'andy',8,25.5),
        (58,'rusty',10,35.0),
        (64,'horatio',7,35.0),
        (71,'zorba',10,16.0),
        (74,'horatio',9,35.0),
        (85,'art',3,25.5),
        (95,'bob',3,63.5);

insert into reserve
values 
		(22,101,'10/10/98'),
        (22,102,'10/10/98'),
        (22,103,'10/8/98'),
        (22,104,'10/7/98'),
        (31,102,'11/10/98'),
        (31,103,'11/6/98'),
        (32,104,'11/12/98'),
        (64,101,'9/5/98'),
        (64,102,'9/8/98'),
        (74,103,'9/8/98');
        
select s.sname,s.age
from sailor s;

select s.sname,s.rating
from sailor s
where s.rating not between 0 and 7;

/*select r.bid
from reserve r
where r.bid='103';*/

select s.sname,r.bid
from  sailor s, reserve r
where r.sid=s.sid and r.bid in (103);

select s.sname, b.color
from  boat b, reserve r, sailor s
where r.sid=s.sid and r.bid=b.bid and b.color = ('red');

select s.sname, b.color
from  boat b, reserve r, sailor s
where r.sid=s.sid and r.bid=b.bid and s.sname = ('lubber');

select s.sname
from sailor s
where  s.sid in
 (select r.sid
  from reserve r);
	
select s.sname,s.age
from sailor s 
where s.sname like 'b_b';

select distinct s.sname,b.color
from  sailor s, boat b, reserve r
where r.bid=b.bid and s.sid=r.sid and b.color in ('red','green');

select s.sid,s.rating
from  sailor s
where s.rating = 10 or s.sid in (select r.sid
								 from reserve r
								 where r.bid =104);
	 