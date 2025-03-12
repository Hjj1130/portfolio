. ./info.sh

isql -U${TOBE_DB_USER} -S${TOBE_DB_SERVER} -P${TOBE_DB_PWD} -w999 << _! > `echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_`date +%Y%m%d`.log

use kfsb2
go

sp_helpuser	
go

select suid, name from master..syslogins where name in ('insu', 'kbiz_nxt')
go

select * from sysusers
go

sp_configure 'allow update', 1
go

update sysusers set suid=14 from sysusers where name='insu'
go
update sysusers set suid=22 from sysusers where name='kbiz_nxt'
go

sp_helpuser
go

sp_configure 'allow update', 0
go

exit
_!
