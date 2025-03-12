. ./info.sh

isql -U${TOBE_DB_USER} -S${TOBE_DB_SERVER} -P${TOBE_DB_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_`date +%Y%m%d`.log

use master
go

select 'Start Time : '+ convert(varchar(30), getdate(),108)
go

dump database kfsb2 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/kfsb2.dmp' with compression=101
go
dump database USERDB1 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/USERDB1.dmp' with compression=101
go
dump database USERDB3 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/USERDB3.dmp' with compression=101
go
dump database USERDB5 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/USERDB5.dmp' with compression=101
go
dump database USERDB4 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/USERDB4.dmp' with compression=101
go
dump database USERDB2 to '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/USERDB2.dmp' with compression=101
go

select 'End Time : '+ convert(varchar(30), getdate(),108)
go

exit
_!
