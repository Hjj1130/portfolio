. ../info.sh

if  [ $# -lt 1 ]
then
        echo '' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo 'Usage : gen_grant.sh [DB_name] ' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        echo '' >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_$1_`date +%Y%m%d`.out
        exit
fi

if  [ $# -eq 1 ]
then
        DB_NAME=$1
fi

echo -e "use $1\n" >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

echo -e "go\n" >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

echo -e "grant all to fund" >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

echo -e "go\n" >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -w999 -b << _!

use $1
go

set nocount on
go

select 'grant select on ' + user_name(uid) + '.' + name + ' to FUNDSL' + char(10) + 'go' + char(10)
from sysobjects where type in ("U","V")
go >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

select 'grant execute on ' + user_name(uid) + '.' + name + ' to FUNDSL' + char(10) + 'go' + char(10)
from sysobjects where type ="P"

go >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

select 'grant select on ' + user_name(uid) + '.' + name + ' to FUNDAP' + char(10) + 'go' + char(10)
from sysobjects where type in ("U","V")

go >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

select 'grant execute on ' + user_name(uid) + '.' + name + ' to FUNDAP' + char(10) + 'go' + char(10)
from sysobjects where type ="P"

go >> ${WORK_PATH}/$1/TOBE_grant_revoke_user.sql

exit

_!

isql -U${TOBE_DB_USER} -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i${WORK_PATH}/$1/TOBE_grant_revoke_user.sql -o${WORK_PATH}/$1/TOBE_grant_revoke_user.log
