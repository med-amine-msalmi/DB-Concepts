use vehicleDB; 
select* from vehicleDetails;


--create virtual table using view 
create view VehicleMasterDetails as 
select ID,Makes.MakeID,Make,MakeModels.ModelID ,ModelName,SubModels.SubModelID,SubModelName,Bodies.BodyID,BodyName,Vehicle_Display_Name, Year ,DriveTypes.DriveTypeID,DriveTypeName,Engine,Engine_CC,Engine_Cylinders,Engine_Liter_Display,FuelTypes.FuelTypeID,FuelTypeName,NumDoors from VehicleDetails
inner join Makes on Makes.MakeID=VehicleDetails.MakeID 
inner join MakeModels on VehicleDetails.ModelID=MakeModels.ModelID 
inner join SubModels on VehicleDetails.SubModelID=SubModels.SubModelID
inner join Bodies on VehicleDetails.BodyID=Bodies.BodyID
inner join DriveTypes on VehicleDetails.DriveTypeID=DriveTypes.DriveTypeID 
inner join FuelTypes on VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID;

select * from VehicleMasterDetails;