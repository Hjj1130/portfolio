. ./info.sh

isql -U${TOBE_DEV_USER} -S${TOBE_DEV_SERVER} -P${TOBE_DEV_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DEV_SERVER}_`date +%Y%m%d`.log

use master
go

sp_helpdb
go

--USERDB4--
use master
go
sp_dboption USERDB4, "trunc log on chkpt", true
go
sp_dboption USERDB4, "select into", true
go
sp_dboption USERDB4, "full logging for all", false
go
use USERDB4
go
checkpoint
go

--USERDB5--
use master
go
sp_dboption USERDB5, "trunc log on chkpt", true
go
sp_dboption USERDB5, "select into", true
go
sp_dboption USERDB5, "full logging for all", false
go
use USERDB5
go
checkpoint
go

--USERDB1--
use master
go
sp_dboption USERDB1, "trunc log on chkpt", true
go
sp_dboption USERDB1, "select into", true
go
sp_dboption USERDB1, "full logging for all", false
go
use USERDB1
go
checkpoint
go

--kfsb2--
use master
go
sp_dboption kfsb2, "trunc log on chkpt", true
go
sp_dboption kfsb2, "select into", true
go
sp_dboption kfsb2, "full logging for all", false
go
use kfsb2
go
checkpoint
go

--USERDB2--
use master
go
sp_dboption USERDB2, "trunc log on chkpt", true
go
sp_dboption USERDB2, "select into", true
go
sp_dboption USERDB2, "full logging for all", false
go
use USERDB2
go
checkpoint
go

--USERDB3--
use master
go
sp_dboption USERDB3, "trunc log on chkpt", true
go
sp_dboption USERDB3, "select into", true
go
sp_dboption USERDB3, "full logging for all", false
go
use USERDB3
go
checkpoint
go

sp_helpdb
go

exit
_!
