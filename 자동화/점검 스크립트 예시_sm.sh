#!/usr/bin/sh
SERVERNM="HEQ"
LOGINNM="sapsa"
LOGINPWD=$1

if [ $# -eq 0 ]
then
	exit
fi

C_DATE=`date +%Y%m%d`

echo "################################################"  > ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 1) Check DB Server Log                       #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

egrep -i "error|fail|stack|dopen|warning" $SYBASE/$SYBASE_ASE/install/${SERVERNM}.log | grep -v "Error: 1608" | grep -v "Error: 1621" | tail -100 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo "################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 2-1) Check error from Backup Server Log      #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

egrep -i "error|fail|stack" $SYBASE/$SYBASE_ASE/install/${SERVERNM}_BS.log | tail -100 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 2-2) Check Backup complete from Backup Server Log #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

egrep -i "\(database " $SYBASE/$SYBASE_ASE/install/${SERVERNM}_BS.log | tail -100 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log


echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 3) usage for filesystem                           #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

df -h $SYBASE                                           >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log


echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 4) sp_monitorconfig                               #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
## usage resource
isql -U${LOGINNM} -P${LOGINPWD} -S${SERVERNM} -w500 -X <<_!  >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
use master
go
sp_monitorconfig 'all'
go
_!

echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 5) usage for connection, lock                     #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

isql -U${LOGINNM} -P${LOGINPWD} -S${SERVERNM} -w500 -X <<_!  >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
use master
go
--number of process
select 'PROCESS_CNT : ' + convert(varchar(10), count(*)) from sysprocesses
go
--number of locks
select 'LOCK_CNT : '    + convert(varchar(10), count(*)) from syslocks
go
--oldest transaction
print "syslogshold info"
go
select db_name(dbid), *                                  from syslogshold
go
_!

#echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
#echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

#echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
#echo "# 6) sp_sysmon                                      #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
#echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
#echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

#isql -U${LOGINNM} -P${LOGINPWD} -S${SERVERNM} -w500 -X <<_!  >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
#use master
#go
#sp_sysmon "00:00:30"
#go
#_!

echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log


echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "# 7) sp_dbspace                                     #" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo "#####################################################" >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

isql -U${LOGINNM} -P${LOGINPWD} -S${SERVERNM} -w500 -X <<_!  >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
use master
go
sp_dbspace
go
_!

echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
echo ""                                                 >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log
