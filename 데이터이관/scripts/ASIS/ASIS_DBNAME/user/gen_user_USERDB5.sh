. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_user.sh [DB_name] ]
#


if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_user.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

mkdir $1
cd $1

ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TUSR -D$1 -Jeucksc -N% -F% -O$1_cr_user.sql

sed 's/^Grant/--Grant/g' < ${WORK_PATH}/$1/$1_cr_user.sql> ${WORK_PATH}/$1/$1_user_1.sql
rm ${WORK_PATH}/$1/$1_cr_user.sql
mv ${WORK_PATH}/$1/$1_user_1.sql $1_user.sql

sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/$1_user.sql> ${WORK_PATH}/$1/$1_user_1.sql
rm ${WORK_PATH}/$1/$1_user.sql
mv ${WORK_PATH}/$1/$1_user_1.sql $1_user.sql

sed '/fund_sm1/s/^/--/g' < ${WORK_PATH}/$1/$1_user.sql> ${WORK_PATH}/$1/$1_user_1.sql
rm ${WORK_PATH}/$1/$1_user.sql
mv ${WORK_PATH}/$1/$1_user_1.sql $1_user.sql


sed '/fund_sm2/s/^/--/g' < ${WORK_PATH}/$1/$1_user.sql> ${WORK_PATH}/$1/$1_user_1.sql
rm ${WORK_PATH}/$1/$1_user.sql
mv ${WORK_PATH}/$1/$1_user_1.sql $1_user.sql
