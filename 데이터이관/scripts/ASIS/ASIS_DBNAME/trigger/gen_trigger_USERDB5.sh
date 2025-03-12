. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_trigger.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_trigger.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi


mkdir ${WORK_PATH}/$1
cd ${WORK_PATH}/$1


ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TTR -D$1 -N% -Jeucksc -FI,RI,KC,PC -O$1_trigger.sql


sed 's///g' < ${WORK_PATH}/$1/$1_trigger.sql > ${WORK_PATH}/$1/$1_trigger1.sql
rm ${WORK_PATH}/$1/$1_trigger.sql
mv ${WORK_PATH}/$1/$1_trigger1.sql $1_trigger.sql

sed 's/\.dbo\./\.fund\./g' < ${WORK_PATH}/$1/$1_trigger.sql > ${WORK_PATH}/$1/$1_trigger1.sql
rm ${WORK_PATH}/$1/$1_trigger.sql
mv ${WORK_PATH}/$1/$1_trigger1.sql $1_trigger.sql

sed 's/dbo\./fund\./g' < ${WORK_PATH}/$1/$1_trigger.sql > ${WORK_PATH}/$1/$1_trigger1.sql
rm ${WORK_PATH}/$1/$1_trigger.sql
mv ${WORK_PATH}/$1/$1_trigger1.sql $1_trigger.sql

sed "s/'dbo'/'fund'/g" < ${WORK_PATH}/$1/$1_trigger.sql > ${WORK_PATH}/$1/$1_trigger1.sql
rm ${WORK_PATH}/$1/$1_trigger.sql
mv ${WORK_PATH}/$1/$1_trigger1.sql $1_trigger.sql
