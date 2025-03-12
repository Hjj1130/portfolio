. ./info.sh

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} <<_! > `echo $0 | cut -d'.' -f1`_`date +%Y%m%d`.log
set nocount on
go

use USERDB6
go

print "--em_tran--"
exec sp_chgattribute TEST_tran, 'identity_gap' , 1000
print "-- em_tran_mms--"
exec sp_chgattribute  TEST_tran_mms, 'identity_gap' , 1000
go

exit
_!
