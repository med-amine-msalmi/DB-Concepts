use vehicleDB; 
--Get all Vehicles made between 1950 and 2000 
select *from VehicleDetails
where Year between 1950 and 2000 ;

--Get number of vehicles made between 1950 and 2000
select count(*) as vehiclesNumber from VehicleDetails
where Year between 1950 and 2000 
select  distinct makeID from vehicleDetails;

--Get number of vehciles made between 1950 and 2000 and order them by Number of Vehicles Descending
select Makes.Make,  count(*) as vehiclesNumber from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
order by vehiclesNumber desc ;

--Get all Makes that have manufactured more than 12000 vehicles in years 1950 and 2000
select Makes.Make,  count(*) as vehiclesNumber from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
having count(*) >=12000
order by vehiclesNumber desc ;

----get all Makes that have manufactured more than 12000 vehicles in years 1950 and 2000 without having
select * from 
(
select Makes.Make,  count(*) as vehiclesNumber from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
)as t
where t.vehiclesNumber >= 12000 
order by t.vehiclesNumber desc;
	
--Get all Makes that have manufactured more than 12000 vehicles in years 1950 and 2000 and add total vehicles column beside 
select Makes.Make,  count(*) as vehiclesNumber ,(select count(*) from VehicleDetails )as TotalVehicles from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
order by vehiclesNumber desc ;

--Get all Makes that have manufactured more than 12000 vehicles in years 1950 and 2000 
--and add total vehicles column beside then calculate it's percentage 
--first method
select Makes.Make,  count(*) as vehiclesNumber ,(select count(*) from VehicleDetails )as TotalVehicles,
 Perc=cast (count(*) as float)*100/ cast((select count(*) from VehicleDetails) as float)
from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
order by vehiclesNumber desc ;

--second method
select Make,vehiclesNumber,TotalVehicles ,Perc=cast(vehiclesNumber as float)*100/cast(TotalVehicles as float)from
(
select Makes.Make,  count(*) as vehiclesNumber ,(select count(*) from VehicleDetails )as TotalVehicles
from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Year between 1950 and 2000
group by Makes.Make
) as t
order by vehiclesNumber desc ;

--Get Make , FuelTypeName and Number of vehicles per FueltType Per Make between 1950 and 2000
select Makes.Make, FuelTypes.FuelTypeName, count(*) as VehiclesNumber from VehicleDetails
inner join  Makes on Makes.MakeID=VehicleDetails.MakeID
inner join FuelTypes on FuelTypes.FuelTypeID=VehicleDetails.FuelTypeID
where Year between 1950 and 2000
group by Makes.Make,FuelTypes.FuelTypeName
order by Makes.Make;

--Get all vehicles runs with gaz
select *from VehicleDetails 
inner join FuelTypes on FuelTypes.FuelTypeID=VehicleDetails.FuelTypeID
where FuelTypeName='GAS';

--Get all makes runs with gaz
select distinct(Makes.Make),FuelTypes.FuelTypeName from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
inner join FuelTypes on FuelTypes.FuelTypeID=VehicleDetails.FuelTypeID
where FuelTypeName='GAS';

--Get Total makes that runs with gas 
select count(*) as TotalMakes from
(
select distinct(Makes.Make) from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
inner join FuelTypes on FuelTypes.FuelTypeID=VehicleDetails.FuelTypeID
where FuelTypeName='GAS'
) as t;

--Count Vehicles by make and order them by NumberOfVehicles Desc 
select Makes.Make,count(*) as TotalVehicles from VehicleDetails 
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
group by Makes.Make
order by TotalVehicles Desc;

--Get all makes of vehicles that manufacture more than 20K Vehicles 
select Makes.Make,count(*) as TotalVehicles from VehicleDetails 
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
group by Makes.Make
having count(*)>20000
order by TotalVehicles Desc;

--Get all Makes with make starts with 'B'
select *from Makes
where Make like 'B%';

-- Get all Makes with make ends with 'W'
 select *from Makes 
 where Make like '%w';

 --Get all Makes that manufactures DriveTypeName = FWD
 select DISTINCT(Makes.Make),DriveTypes.DriveTypeName from VehicleDetails 
 inner join Makes on Makes.MakeID=VehicleDetails.MakeID
 inner join DriveTypes on DriveTypes.DriveTypeID=VehicleDetails.DriveTypeID
 where DriveTypes.DriveTypeName='FWD'

 --Get total Makes that Mantufactures DriveTypeName=FWD
 select count(*) from
 (
  select DISTINCT(Makes.Make),DriveTypes.DriveTypeName from VehicleDetails 
 inner join Makes on Makes.MakeID=VehicleDetails.MakeID
 inner join DriveTypes on DriveTypes.DriveTypeID=VehicleDetails.DriveTypeID
 where DriveTypes.DriveTypeName='FWD'
 )as R;

 --Get total vehicles per DriveTypeName Per Make and order them per make asc then per total Desc
 select DriveTypes.DriveTypeName,Makes.Make,count(*) as TotalVehicles
 from VehicleDetails inner join Makes on Makes.MakeID=VehicleDetails.MakeID
 inner join DriveTypes on DriveTypes.DriveTypeID=VehicleDetails.DriveTypeID
 group by DriveTypes.DriveTypeName,Makes.Make
 order by Makes.Make asc ,DriveTypes.DriveTypeName;

--Get total vehicles per DriveTypeName Per Make then filter only results with total > 10,000
select DriveTypes.DriveTypeName , Makes.Make, count(*) as TotalVehicles from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID 
inner join DriveTypes on DriveTypes.DriveTypeID=VehicleDetails.DriveTypeID 
group by DriveTypes.DriveTypeName,Makes.Make
having count(*) >= 10000
order by TotalVehicles desc;

--Get all Vehicles that number of doors is not specified
select count(*) as TotalVehicles from VehicleDetails 
where NumDoors is null;

--Get percentage of vehicles that has no doors specified
select Persc=cast((select count(*) from VehicleDetails 
             where NumDoors is null) as float) *100 / cast( ( select count(*) from VehicleDetails) as float  )

--Get MakeID , Make, SubModelName for all vehicles that have SubModelName 'Elite'
select distinct VehicleDetails.MakeID , Makes.Make , SubModels.SubModelName from VehicleDetails 
inner join Makes on Makes.MakeID = VehicleDetails.MakeID 
inner join SubModels on VehicleDetails.SubModelID=SubModels.SubModelID
where SubModels.SubModelName='Elite';

--Get all vehicles that have Engines > 3 Liters and have only 2 doors
select * from VehicleDetails 
where Engine_Liter_Display>3 
and NumDoors=2

--Get make and vehicles that the engine contains 'OHV' and have Cylinders = 4
select Makes.Make,*from VehicleDetails 
inner join Makes on Makes.MakeID=VehicleDetails.MakeID
where Engine like '%OHV%'
and Engine_Cylinders=4;

--Get all vehicles that their body is 'Sport Utility' and Year > 2020
select * from VehicleDetails
inner join Bodies on Bodies.BodyID=VehicleDetails.BodyID
where BodyName='Sport Utility'
and Year>2020;

--Get all vehicles that their Body is 'Coupe' or 'Hatchback' or 'Sedan'
select *from VehicleDetails 
inner join Bodies on Bodies.BodyID=VehicleDetails.BodyID
where Bodies.BodyName in ('Coupe','Hatchback','Sedan');

--Get all vehicles that their body is 'Coupe' or 'Hatchback' or 'Sedan' and manufactured in year 2008 or 2020 or 2021
select *from VehicleDetails 
inner join Bodies on Bodies.BodyID=VehicleDetails.BodyID
where Bodies.BodyName in ('Coupe','Hatchback','Sedan')
and VehicleDetails.year in (2008,2020,2021)

--Return found=1 if there is any vehicle made in year 1950
--Methode 1)
    select  
    	case 
    		when (select count(*) from VehicleDetails where Year=1950) > 0 then 1
    		else 0
    	end 
    as Found ;
--Methode 2)
    select found=1 where exists 
    (select top 1 * from VehicleDetails where Year=1950); 
--Get all Vehicle_Display_Name, NumDoors and add extra column to describe number of doors by words,
--and if door is null display 'Not Set'
select VehicleDetails.Vehicle_Display_Name ,VehicleDetails.NumDoors,
case
	when VehicleDetails.NumDoors =1 then 'one door'
	when  VehicleDetails.NumDoors =2 then 'two doors'
	when  VehicleDetails.NumDoors =3 then 'three doors'
	when  VehicleDetails.NumDoors =4 then 'four doors'
	when VehicleDetails.NumDoors =8 then 'eight doors'
	when VehicleDetails.NumDoors is null then 'Not Set' 
end as DoorDescription 
from VehicleDetails

-- Problem 31: Get all Vehicle_Display_Name, year and add extra column to calculate the age
--of the car then sort the results by age desc.
select Vehicle_Display_Name,year,Age=year(getdate())- year from VehicleDetails
order by Age desc;

--Get all Vehicle_Display_Name, year, Age for vehicles that their age 
--between 15 and 25 years old 
select * from
(
select VehicleDetails.Vehicle_Display_Name,year,year(getdate())-year as age
from VehicleDetails
)as R
where age between 15 and 25 
order by age desc;

--Get Minimum Engine CC , Maximum Engine CC , and Average Engine CC of all Vehicles
select min(VehicleDetails.Engine_CC) as Minimum ,max(Engine_CC) as Maximum,avg(Engine_CC)
from VehicleDetails;

--Get all vehicles that have the minimum Engine_CC
select *from VehicleDetails
where Engine_CC=(select min(Engine_CC ) from VehicleDetails);

--Get all vehicles that have the maximum Engine_CC
select *from VehicleDetails
where Engine_CC=(select max(Engine_CC ) from VehicleDetails);

--Get all vehicles that have Engine_CC below average
select *from VehicleDetails
where Engine_CC <(select avg(Engine_CC ) from VehicleDetails);