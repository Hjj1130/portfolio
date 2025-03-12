. ./info.sh

isql -U${TOBE_DEV_USER} -S${TOBE_DEV_SERVER} -P${TOBE_DEV_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DEV_SERVER}_`date +%Y%m%d`.log

use master
go

online database USERDB1
go
online database USERDB3
go
online database USERDB5
go
online database USERDB4
go
online database kfsb2
go
online database USERDB2
go
exit
_!
