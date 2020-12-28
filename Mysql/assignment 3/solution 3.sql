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
select g.guestname,g.guestaddress
from guest g 
where g.guestaddress like '%london%' 
order by g.guestaddress ASC;

#Q2
select h.hotelname,count(r.hotelno) as NumberOfRooms,count(r.type) as NumberOfTypes
from hotel h,room r
where r.hotelno=h.hotelno
group by h.hotelname;

#Q3
select h.hotelname,count(r.hotelno) as NumberOfRooms,h.city,avg(r.price) as AVGPriceofhotel
from hotel h,room r
where r.hotelno=h.hotelno and h.city='london'
group by h.hotelname;

#Q4
select r.type,MAX(r.price) as MaximumPrice
from room r 
group by r.type
order by r.type;

#Q5
select h.hotelname,count(r.type) as TypesOfRoomsAvailable
from hotel h,room r
where r.hotelno=h.hotelno
group by h.hotelname;

#Q6
select distinct h.hotelname, h.city as CityOfGuests
from hotel h join booking b on b.hotelno=h.hotelno
where h.city = 'london';

#Q7
select h.hotelname, h.city,count(h.hotelno) as No_Of_Reservations
from hotel h, booking b
where b.hotelno=h.hotelno
group by (b.hotelno)
order by b.hotelno DESC;

#Q8
select g.guestname,b.dateto
from guest g join booking b on g.guestno=b.guestno
where b.dateto is null;

#Q9
select h.hotelname, b.roomno,b.guestno,b.datefrom,b.dateto
from hotel h join booking b on b.hotelno=h.hotelno
where b.dateto like '%2004%' 
      or b.dateto like '%2003%'
      or b.datefrom like '%2004%' 
      or b.datefrom like '%2003%';

#Q10
select distinct h.hotelname, h.city
from hotel h 
where h.hotelno not in 
						( select b.hotelno
						  from booking b);

#Q11
select count(b.guestno) as Number_of_guests
from booking b
where b.datefrom <= '2015-05___ 23:59:59';

#Q12
select Sum(r.price) as Total_revenue
from room r 
where r.type='double';

#Q13
select count(b.guestno) as Number_of_guests
from booking b
where b.datefrom like '_____08___ ________';

#Q14
select r.price, r.type
from room r join hotel h on (r.hotelno=h.hotelno and h.hotelname='watergate' and h.city='paris');
#With avari result is null because there is no entry with that hotel name

#Q15
select g.guestname, h.hotelname
from hotel h, booking b, guest g
where h.hotelno=b.hotelno and h.hotelname='watergate';
#With marriot result is null because there is no entry with that hotel name

#Q16
select sum(r.price) as Price,sysdate()
from booking b, hotel h, room r
where b.hotelno=h.hotelno and h.hotelname='watergate' and r.roomno=b.roomno;
#With Hotel Inn result is null because there is no entry with that hotel name

#Q17
select r.roomno
from room r
where r.hotelno in (select h.hotelno
					from hotel h 
                    where h.hotelname='Latham')
      and r.roomno not in (select b.roomno
						   from booking b, hotel h
                           where b.hotelno=h.hotelno and h.hotelname='Latham');
                           
#Q18
select sum(r.price) as LostIncome
from room r
where r.hotelno in (select h.hotelno
					from hotel h 
                    where h.hotelname='Latham')
      and r.roomno not in (select b.roomno
						   from booking b, hotel h
                           where b.hotelno=h.hotelno and h.hotelname='Latham');

#Q19
select h1.hotelname,h1.city,sum(r.price) as LostIncome
from room r, hotel h1
where r.hotelno in (h1.hotelno)
      and r.roomno not in (select b.roomno
						   from booking b,hotel h
                           where b.hotelno=h.hotelno and h.hotelno=h1.hotelno)
group by h1.hotelname;


#Q20
#Creating view for hotels with more than 2 types of rooms
create view hotelwith3rooms as
select *
from hotel h natural join room r
group by h.hotelname
having count(r.roomno)>2;

select T.hotelname,T.city,sum(r.price) as LostIncome
from hotelwith3rooms T, room r
where r.hotelno in (T.hotelno)
      and r.roomno not in (select b.roomno
						   from booking b,hotel h
                           where b.hotelno=h.hotelno and h.hotelno=T.hotelno)
group by T.hotelname;
