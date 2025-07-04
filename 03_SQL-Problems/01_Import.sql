--Restore Database
restore Database vehicleDB
from disk='C:\Backup\VehicleMakesDB.bak'

-- alter current user to system admin
ALTER AUTHORIZATION ON DATABASE::vehicleDB TO sa;

use vehicleDb;
select* from FuelTypes;

select *from vehicleDetails 
full outer join FuelTypes on VehicleDetails.FuelTypeID=FuelTypes.FuelTypeID

where FuelTypes.FuelTypeName='GAS';