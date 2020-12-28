create schema University;

create table campus
( CampusID int not null,
  CampusName varchar(30) not null,
  CampusAddress varchar(50),
  Country varchar(20),
  City varchar(20),
  IsOpen bit(1) not null, 
  /* (b'1' = Uni is open &
      b'0' = Uni is off) */
  primary key (CampusID) );
  
  create table building
  ( BuildingID int(5) not null,
    BuildingName varchar(30),
    Address varchar(30),
    CampusID int,
    primary key (BuildingID),
    foreign key CampusID_0f_building(CampusID)
		references campus(CampusID)
        on delete set null
        on update cascade
    );
    

	 insert into campus
    values 
			('1','EE','Main Campus Lahore','Pakistan','lahore',1),
            ('2','Ksk','Minar e Pakistan','Pakistan','lahore',1),
            ('3','Faislabad','Canal Road','Pakistan','Faislabad',1),
            ('4','Rachna','M2','Pakistan','Rawalpindi',1),
            ('5','RCET','Ring Road','Pakistan','Gujranwala',b'1');  
            
      insert into building
    values 
			('1','EE','Main Campus Lahore','1'),
            ('2','CS','Main Campus Lahore','1'),
            ('3','ME','Main Campus Lahore','1'),
            ('4','AR','Main Campus Lahore','3'),
            ('5','CE','Main Campus Lahore','2');
	
    select *
    from   campus;
    
    select *
    from   building;
    
   select *
   from building
   where building.CampusID = 1 ;
   
   alter table campus
   change column `CampusName` `mycampus` varchar(20);
   
   alter table campus
   drop column  `mycampus`;