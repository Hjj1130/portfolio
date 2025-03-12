. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_view.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_view.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi


mkdir ${WORK_PATH}/$1
cd ${WORK_PATH}/$1

ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TV -D$1 -Jeucksc -N% -O$1_view.sql

sed 's/^Grant/--Grant/g' < ${WORK_PATH}/$1/$1_view.sql> ${WORK_PATH}/$1/$1_view_1.sql
rm ${WORK_PATH}/$1/$1_view.sql
mv ${WORK_PATH}/$1/$1_view_1.sql $1_view.sql

sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/$1_view.sql> ${WORK_PATH}/$1/$1_view_1.sql
rm ${WORK_PATH}/$1/$1_view.sql
mv ${WORK_PATH}/$1/$1_view_1.sql $1_view.sql

sed 's///g' < ${WORK_PATH}/$1/$1_view.sql> ${WORK_PATH}/$1/$1_view_1.sql
rm ${WORK_PATH}/$1/$1_view.sql
mv ${WORK_PATH}/$1/$1_view_1.sql $1_view.sql
