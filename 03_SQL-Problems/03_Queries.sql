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
