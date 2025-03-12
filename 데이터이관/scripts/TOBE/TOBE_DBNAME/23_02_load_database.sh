. ./info.sh

isql -U${TOBE_DEV_USER} -S${TOBE_DEV_SERVER} -P${TOBE_DEV_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DEV_SERVER}_`date +%Y%m%d`.log

use master
go

#load database kfsb2 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/kfsb2.dmp'
go
load database USERDB1 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/USERDB1.dmp'
go
load database USERDB3 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/USERDB3.dmp'
go
load database USERDB5 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/USERDB5.dmp'
go
load database USERDB4 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/USERDB4.dmp'
go
load database USERDB2 from '/app/sybase/NO_DEL/03_ASE_MIG/MIG_TEST5/TOBE/TOBE_DBNAME/DUMP/USERDB2.dmp'
go

exit
_!
