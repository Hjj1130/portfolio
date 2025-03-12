. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_procs.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : gen_procs.sh [DB_name] '
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

sed 's/\.dbo\./\.fund\./g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql


sed 's/dbo\./fund\./g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql


sed "s/'dbo'/'fund'/g" < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

sed 's!FUND_DB\.\.!FUND_DB\.fund\.!g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

sed 's!FUND_BK\.\.!FUND_BK\.fund\.!g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

sed 's/^Grant/--Grant/g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

sed 's///g' < ${WORK_PATH}/$1/${procs_line}.sql > ${WORK_PATH}/$1/${procs_line}2.sql
rm ${WORK_PATH}/$1/${procs_line}.sql
mv ${WORK_PATH}/$1/${procs_line}2.sql ${WORK_PATH}/$1/${procs_line}.sql

done

#수정할 프로시저 삭제 후 수정된 프로시저 복사
rm -rf usp_cl22_07_3.sql usp_cl22_06_5_wms_1.sql usp_cl22_06_5_all.sql usp_cl22_06_5.sql usp_cl_dpct_ints01.sql usp_ad_hoc_analysis_inst.sql usp_cm00_get_seq_no.sql usp_get_seq_num.sql usp_get_sys22ld.sql 

cd ../NEW

cp -R usp_cl22_07_3.sql usp_cl22_06_5_wms_1.sql usp_cl22_06_5_all.sql usp_cl22_06_5.sql usp_cl_dpct_ints01.sql usp_ad_hoc_analysis_inst.sql usp_cm00_get_seq_no.sql usp_get_seq_num.sql usp_get_sys22ld.sql f_app_data_split.sql ${WORK_PATH}/$1


ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TP -Jeucksc -N$1.%.usp_mon_mdlstb2 -O${WORK_PATH}/$1/usp_mon_mdlstb2.sql

sed 's/\.dbo\./\.fund\./g' < ${WORK_PATH}/$1/usp_mon_mdlstb2.sql > ${WORK_PATH}/$1/usp_mon_mdlstb22.sql
rm ${WORK_PATH}/$1/usp_mon_mdlstb2.sql
mv ${WORK_PATH}/$1/usp_mon_mdlstb22.sql ${WORK_PATH}/$1/usp_mon_mdlstb2.sql

sed 's/'dbo'/'fund'/g' < ${WORK_PATH}/$1/usp_mon_mdlstb2.sql > ${WORK_PATH}/$1/usp_mon_mdlstb22.sql
rm ${WORK_PATH}/$1/usp_mon_mdlstb2.sql
mv ${WORK_PATH}/$1/usp_mon_mdlstb22.sql ${WORK_PATH}/$1/usp_mon_mdlstb2.sql

cd ${WORK_PATH}/$1
ls >> ${WORK_PATH}/$1_procs_list.sql
