. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_ddl.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : gen_ddl.sh [DB_name] '
        echo ''
        exit
fi
if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi


mkdir ${WORK_PATH}/$1
cd ${WORK_PATH}/$1

isql -U$ASIS_DB_USER -P$ASIS_DB_PWD -S$ASIS_DB_SERVER -b <<_! > ${WORK_PATH}/$1_table_list.sql
set nocount on
go
use $1
go
select name from sysobjects where type='P' 
--and name not in ('')
go

_!




cat ${WORK_PATH}/$1_table_list.sql | while read line 

do

procs_line="$line"
ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TP -Jeucksc -N$1.%.${procs_line} -O${WORK_PATH}/$1/${procs_line}.sql 

sed 's/^M//g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql


sed 's/^Grant/--Grant/g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql


sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

done


cd ${WORK_PATH}/$1
ls >> ${WORK_PATH}/$1_procs_list.sql

