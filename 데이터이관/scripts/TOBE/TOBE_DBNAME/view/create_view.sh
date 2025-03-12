. ../info.sh

#!/bin/sh
#
#  [ Usage : 19_create_view.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : 19_create_view.sh [DB_name] '
        echo ''
        exit
fi
if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i${WORK_PATH}/$1/$1_view.sql -o${WORK_PATH}/$1/`echo $0 | cut -d'.' -f1`_${TOBE_DB_SERVER}_$1_`date +%Y%m%d`.log
