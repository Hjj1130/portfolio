. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_table.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_table.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi


mkdir ${WORK_PATH}/$1
cd ${WORK_PATH}/$1

ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TU -D$1 -N% -Jeucksc -F% -O$1_table.sql

sed 's/^Grant/--Grant/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed 's/^sp_/--sp_/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed 's/decimaln/decimal/g' < ${WORK_PATH}/$1/$1_table.sql > ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed 's/intn/int/g' < ${WORK_PATH}/$1/$1_table.sql > ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed '/CREATING Table - "FUND2.dbo.tbae010"/,/-----/s/^/--/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed '/CREATING Table - "FUND2.dbo.tbcd010"/,/-----/s/^/--/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

sed '/CREATING Table - "FUND2.dbo.tbrd010"/,/-----/s/^/--/g' < ${WORK_PATH}/$1/$1_table.sql> ${WORK_PATH}/$1/$1_table_1.sql
rm ${WORK_PATH}/$1/$1_table.sql
mv ${WORK_PATH}/$1/$1_table_1.sql $1_table.sql

echo "isql -U$TOBE_DB_USER -P$TOBE_DB_PWD -S$TOBE_DB_SERVER -w999 <<_EOF > Grant_public.log" > ${WORK_PATH}/$1/Grant_public1.sql
echo "use $1" >> ${WORK_PATH}/$1/Grant_public1.sql
echo "go" >> ${WORK_PATH}/$1/Grant_public1.sql

egrep -i "Grant" < ${WORK_PATH}/$1/$1_table.sql > ${WORK_PATH}/$1/Grant_public.sql
egrep -i "public" < ${WORK_PATH}/$1/Grant_public.sql >> ${WORK_PATH}/$1/Grant_public1.sql
rm ${WORK_PATH}/$1/Grant_public.sql
mv ${WORK_PATH}/$1/Grant_public1.sql Grant_public.sql

sed 's/----Grant/--Grant/g' < ${WORK_PATH}/$1/Grant_public.sql > ${WORK_PATH}/$1/Grant_public1.sql
rm ${WORK_PATH}/$1/Grant_public.sql
mv ${WORK_PATH}/$1/Grant_public1.sql Grant_public.sql

sed 's/--Grant/Grant/g' < ${WORK_PATH}/$1/Grant_public.sql > ${WORK_PATH}/$1/Grant_public1.sql
rm ${WORK_PATH}/$1/Grant_public.sql
mv ${WORK_PATH}/$1/Grant_public1.sql Grant_public.sql

sed  -e '/public/a\go' < ${WORK_PATH}/$1/Grant_public.sql > ${WORK_PATH}/$1/Grant_public1.sql
rm ${WORK_PATH}/$1/Grant_public.sql
mv ${WORK_PATH}/$1/Grant_public1.sql Grant_public.sql

echo "_EOF" >> ${WORK_PATH}/$1/Grant_public.sql

