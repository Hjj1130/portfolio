. ../info.sh

#!/bin/sh
#
#  [ Usage : 11_create_table.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : 11_create_table.sh [DB_name] '
        echo ''
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i${WORK_PATH}/$1/$1_table.sql -o${WORK_PATH}/$1/$1_table_`date +%Y%m%d`.log

sh ${WORK_PATH}/$1/Grant_public.sql
