. ./info.sh

isql -U${TOBE_DB_USER} -S${TOBE_DB_SERVER} -P${TOBE_DB_PWD} << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_`date +%Y%m%d`.log

use master
go

load database kfsb2 from '/app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/DUMP/kfsb2.dmp'
go

online database kfsb2
go

exit
_!
