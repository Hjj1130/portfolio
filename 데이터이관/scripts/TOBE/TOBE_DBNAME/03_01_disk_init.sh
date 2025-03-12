. ./info.sh

isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} <<_! > `echo $0 | cut -d'.' -f1`_`date +%Y%m%d`.log
use master
go

disk init name='USERDB4_data_001', physname='/data/DATA/USERDB4_data_001.dat', size='30000M'
go
disk init name='USERDB4_data_002', physname='/data/DATA/USERDB4_data_002.dat', size='30000M'
go
disk init name='USERDB4_data_003', physname='/data/DATA/USERDB4_data_003.dat', size='30000M'
go
disk init name='USERDB4_log_001' , physname='/data/LOG/USERDB4_log_001.dat'     , size='20000M'
go

disk init name='USERDB1_data_001', physname='/data/DATA/USERDB1_data_001.dat', size='30000M'
go
disk init name='USERDB1_data_002', physname='/data/DATA/USERDB1_data_002.dat', size='30000M'
go
disk init name='USERDB1_data_003', physname='/data/DATA/USERDB1_data_003.dat', size='30000M'
go
disk init name='USERDB1_data_004', physname='/data/DATA/USERDB1_data_004.dat', size='30000M'
go
disk init name='USERDB1_log_001' , physname='/data/LOG/USERDB1_log_001.dat'     , size='20000M'
go

disk init name='USERDB2_data_001', physname='/data/DATA/USERDB2_data_001.dat', size='5000M'
go
disk init name='USERDB2_log_001' , physname='/data/LOG/USERDB2_log_001.dat'     , size='2000M'
go

disk init name='USERDB5_data_001', physname='/data/DATA/USERDB5_data_001.dat', size='30000M'
go
disk init name='USERDB5_data_002', physname='/data/DATA/USERDB5_data_002.dat', size='15000M'
go
disk init name='USERDB5_log_001' , physname='/data/LOG/USERDB5_log_001.dat'     , size='10000M'
go

disk init name='USERDB3_data_001', physname='/data/DATA/USERDB3_data_001.dat', size='30000M'
go
disk init name='USERDB3_log_001' , physname='/data/LOG/USERDB3_log_001.dat'     , size='10000M'
go

disk init name='USERDB6_data_001', physname='/data/DATA/USERDB6_data_001.dat', size='2000M'
go
disk init name='USERDB6_log_001', physname='/data/LOG/USERDB6_log_001.dat', size='1000M'
go

_!
