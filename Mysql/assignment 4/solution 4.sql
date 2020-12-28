# 2017EE90
# HASSAN YOUSAF BARA
create schema hotelBooking;

create table hotel
( hotelno varchar(10),
  hotelname varchar(20),
  city varchar(20),
  primary key (hotelno)
);

insert into hotel
values 
		('fb01', 'Grosvenor', 'London'),
        ('fb02', 'Watergate', 'Paris'),
        ('ch01', 'Omni Shoreham', 'London'),
        ('ch02', 'Phoenix Park', 'London'),
        ('dc01', 'Latham', 'Berlin');
        
create table room
( roomno numeric(5),
  hotelno varchar(10),
  type varchar(10),
  price decimal(5,2),
  primary key (roomno,hotelno),
  foreign key room_hotelno(hotelno)
	references hotel(hotelno)
    on update cascade
);

insert into room
values 
		(501, 'fb01', 'single', 19),
        (601, 'fb01', 'double', 29),
        (701, 'fb01', 'family', 39),
        (1001, 'fb02', 'single', 58),
        (1101, 'fb02', 'double', 86),
        (1001, 'ch01', 'single', 29.99),
        (1101, 'ch01', 'family', 59.99),
        (701, 'ch02', 'single', 10),
        (801, 'ch02', 'double', 15),
        (901, 'dc01', 'single', 18),
        (1001, 'dc01', 'double', 30),
        (1101, 'dc01', 'family', 35);
        
create table guest
( guestno numeric(5),
  guestname varchar(20),
  guestaddress varchar(50),
  primary key(guestno) );
  
insert into guest values(10001, 'John Kay', '56 High St, London');
insert into guest values(10002, 'Mike Ritchie', '18 Tain St, London');
insert into guest values(10003, 'Mary Tregear', '5 Tarbot Rd, Aberdeen');
insert into guest values(10004, 'Joe Keogh', '2 Fergus Dr, Aberdeen');
insert into guest values(10005, 'Carol Farrel', '6 Achray St, Glasgow');
insert into guest values(10006, 'Tina Murphy', '63 Well St, Glasgow');
insert into guest values(10007, 'Tony Shaw', '12 Park Pl, Glasgow');

create table booking
( hotelno varchar(10),
  guestno numeric(5),
  datefrom datetime,
  dateto datetime,
  roomno numeric(5),
  primary key(hotelno, guestno, datefrom),
  foreign key(roomno,hotelno) 
	REFERENCES room(roomno, hotelno)
    on update cascade,
  foreign key(guestno) 
	REFERENCES guest(guestno)
    on update cascade
);
#inserting separately
insert into booking values('fb01', 10001, '02-04-01', '02-04-08', 501);
insert into booking values('fb01', 10004, '04-04-15', '04-05-15',601);
insert into booking values('fb01', 10005, '03-05-02', '03-05-07', 501);
insert into booking values('fb01', 10001, '04-05-01', null, 701);
insert into booking values('fb02', 10003, '09-04-05', '10-04-04', 1001);
insert into booking values('ch01', 10006, '04-04-21', null, 1101);
insert into booking values('ch02', 10002, '04-04-25', '04-05-06', 801);
insert into booking values('dc01', 10007, '06-05-13', '06-05-15', 1001);
insert into booking values('dc01', 10003, '12-05-20', null, 1001);


#Q1
create view LathamHotel as
select *
from (hotel h natural join room r) 
where h.hotelname='latham';

create view LathamHotelDetail as
select distinct l.hotelname, l.roomno,l.type,b.guestno,l.price
from LathamHotel l left join booking b on (l.roomno=b.roomno and l.hotelno=b.hotelno);

select *
from lathamhoteldetail;
#Q2
create view londonguests as
select g.guestname,g.guestaddress,g.guestno
from guest g
where g.guestaddress like '%london%'
order by g.guestname ASC;

#Q3
create view Nulldateto as
select b.datefrom,b.dateto
from booking b
where b.dateto is null;


insert into londonguests
values ('Hassan','London 90','10012');

select*
from londonguests;

#Q5
update lathamhoteldetail 
set lathamhoteldetail.price=60
where lathamhoteldetail.roomno=1001;

#Q6
create table employee
( name varchar(10),
  primary key(name));

create table new_employee
( name varchar(10),
  primary key(name));

create trigger new_emp
after insert on employee 
for each row
insert into new_employee values (new.name);

#To check trigger updating new value
insert into employee
values ('Bara');

#Checking values of new_employee
select *
from new_employee;


