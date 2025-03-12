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


mkdir $1
cd $1

ddlgen -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -TUSR -D$1 -N% -F% -Oall_grant_revoke_user.sql


sed 's/^exec/--exec/g' < all_grant_revoke_user.sql > $1_cr_grant_1.sql
rm all_grant_revoke_user.sql
mv $1_cr_grant_1.sql all_grant_revoke_user.sql

sed 's/^Revoke/--Revoke/g' < all_grant_revoke_user.sql > $1_cr_grant_1.sql
rm all_grant_revoke_user.sql
mv $1_cr_grant_1.sql all_grant_revoke_user.sql
