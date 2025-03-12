. ./info.sh

isql -U${TOBE_DB_USER} -S${TOBE_DB_SERVER} -P${TOBE_DB_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_`date +%Y%m%d`.log

use master
go

sp_helpdb
go

--USERDB4--
use master
go
sp_dboption USERDB4, "enforce dump tran sequence", true
go
use USERDB4
go
checkpoint
go

--USERDB5--
use master
go
sp_dboption USERDB5, "enforce dump tran sequence", true
go
use USERDB5
go
checkpoint
go

--USERDB3--
use master
go
sp_dboption USERDB3, "enforce dump tran sequence", true
go
use USERDB3
go
checkpoint
go

--USERDB1--
use master
go
sp_dboption USERDB1, "enforce dump tran sequence", true
go
use USERDB1
go
checkpoint
go

--kfsb2--
use master
go
sp_dboption kfsb2, "enforce dump tran sequence", true
go
use kfsb2
go
checkpoint
go

--USERDB2--
use master
go
sp_dboption USERDB2, "enforce dump tran sequence", true
go
use USERDB2
go
checkpoint
go

sp_helpdb
go

exit
_!
