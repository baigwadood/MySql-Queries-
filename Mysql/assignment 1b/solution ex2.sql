create schema fitness;

create table gym
( gymName varchar(20) not null,
  owner varchar(20),
  street varchar(30),
  primary key (gymName)
  );
  
  create table customer
  ( customerName varchar(20) not null,
	street varchar(30),
    age float,
    primary key (customerName)
    );
    
    create table frequents
    (  Cname varchar(20),
	   Gname varchar(20),
       primary key (Cname,Gname),
       foreign key Cname_0f_frequent(Cname)
		references customer(customerName)
        on update cascade,
	   foreign key Gname_0f_frequent(Gname)
		references gym(gymName)
        on update cascade
        );
	
	insert into gym
    values 
		('gym1','Hassan','01'),
        ('gym2','Babar','02'),
		('gym3','sarfraz','03');
        
	insert into customer
    values
		('Usman','11','20'),
        ('farid','12','22'),
        ('shahmeer','13','23');
    
    insert into frequents
    values
		('Usman','gym1'),
        ('Shahmeer','gym2');
	
    select Cname,Gname
    from frequents as F
    where F.Cname='Usman';
    
    insert into frequents
    values
		('ahmad','gym1');
	
    
    
    
    insert into customer
    values
		('ahmad','01','29');
        
	select *
    from frequents;

	
    select F.Cname,C.street,F.Gname,G.owner,G.street
    from frequents as F, customer as c, gym as G
    where F.Cname=C.customerName AND F.Gname=G.gymName AND C.street=G.street;