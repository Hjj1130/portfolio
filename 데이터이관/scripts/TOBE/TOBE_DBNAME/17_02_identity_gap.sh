. ./info.sh

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} <<_! > `echo $0 | cut -d'.' -f1`_`date +%Y%m%d`.log
set nocount on
go

use USERDB3
go

print "--tbae010--"
exec sp_chgattribute TEST010, 'identity_gap' , 1000
print "--tbcd010--"
exec sp_chgattribute TEST2010, 'identity_gap' , 1000
print "--tbrd010--"
exec sp_chgattribute TEST3010, 'identity_gap' , 1000
go



exit
_!
