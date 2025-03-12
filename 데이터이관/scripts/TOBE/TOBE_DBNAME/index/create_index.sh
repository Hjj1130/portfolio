. ../info.sh

#!/bin/sh
#
#  [ Usage : 17_create_index.sh [DB_name] ]
#

if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : 17_create_index.sh [DB_name] '
        echo ''
        exit
fi
if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

cd $1
sh create_index_$1.sh
