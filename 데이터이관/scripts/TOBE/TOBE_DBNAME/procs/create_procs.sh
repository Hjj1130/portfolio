. ../info.sh

#!/bin/sh
#
#  [ Usage : 20_create_procs.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : 20_create_procs.sh [DB_name] '
        echo ''
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

cat ${WORK_PATH}/$1_procs_list.sql | while read line 
do

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i${WORK_PATH}/$1/$line -o${WORK_PATH}/$1/$line.log

done

cat ${WORK_PATH}/$1/*.log > ${WORK_PATH}/$1.log
