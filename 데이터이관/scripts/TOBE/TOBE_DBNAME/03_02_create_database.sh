. ./info.sh

isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} <<_! > `echo $0 | cut -d'.' -f1`_`date +%Y%m%d`.log
use master
go

create database USERDB1 on USERDB1_data_001='30000M'
log on USERDB1_log_001='20000M'
go

alter database USERDB1 on USERDB1_data_002='30000M'
go

alter database USERDB1 on USERDB1_data_003='30000M'
go

alter database USERDB1 on USERDB1_data_004='30000M'
go


create database USERDB4 on USERDB4_data_001='30000M'
log on USERDB4_log_001='20000M'
go

alter database USERDB4 on USERDB4_data_002='30000M'
go

alter database USERDB4 on USERDB4_data_003='30000M'
go


create database USERDB5 on USERDB5_data_001='30000M'
log on USERDB5_log_001='10000M'
go

alter database USERDB5 on USERDB5_data_002='15000M'
go

create database USERDB3 on USERDB3_data_001='30000M'
log on USERDB3_log_001='10000M'
go

create database USERDB2 on USERDB2_data_001='5000M'
log on USERDB2_log_001='2000M'
go

create database USERDB6 on USERDB6_data_001='2000M' 
log on USERDB6_log_001='1000M'
go

--USERDB1---
use master
go
sp_dboption USERDB1, "select into", true
go
sp_dboption USERDB1, "trunc log on chkpt", true
go
use USERDB1
go
checkpoint
go

--USERDB5--
use master
go
sp_dboption USERDB5, "select into", true
go
sp_dboption USERDB5, "trunc log on chkpt", true
go
use USERDB5
go
checkpoint
go

--USERDB4--
use master
go
sp_dboption USERDB4, "select into", true
go
sp_dboption USERDB4, "trunc log on chkpt", true
go
use USERDB4
go
checkpoint
go

--USERDB3--
use master
go
sp_dboption USERDB3, "select into", true
go
sp_dboption USERDB3, "trunc log on chkpt", true
go
use USERDB3
go
checkpoint
go

--USERDB2--
use master
go
sp_dboption USERDB2, "select into", true
go
sp_dboption USERDB2, "trunc log on chkpt", true
go
use USERDB2
go
checkpoint
go

--USERDB6--
use master
go
sp_dboption USERDB6, "select into", true
go
sp_dboption USERDB6, "trunc log on chkpt", true
go
use USERDB6
go
checkpoint
go

_!
