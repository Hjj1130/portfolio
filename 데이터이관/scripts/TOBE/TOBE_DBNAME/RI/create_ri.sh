. ../info.sh

#!/bin/sh
#
#  [ Usage : 24_create_ri.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : 24_create_ri.sh [DB_name] '
        echo ''
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i${WORK_PATH}/$1/$1_RI.sql -o${WORK_PATH}/$1/`echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_$1_`date +%Y%m%d`.log
