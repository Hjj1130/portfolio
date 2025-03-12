. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_ri.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_ri.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi


mkdir ${WORK_PATH}/$1
cd ${WORK_PATH}/$1

ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TRI -D$1 -N% -FTR,I -O$1_RI.sql

