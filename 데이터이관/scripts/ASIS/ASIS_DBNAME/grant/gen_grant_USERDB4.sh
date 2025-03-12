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


sed 's/^exec/--exec/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed 's/^Revoke/--Revoke/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed 's/\.dbo\./\.fund\./g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql
 
sed 's/dbo\./fund\./g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql
 
sed "s/'dbo'/'fund'/g" < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed '/co06ld_040714/s/^Grant/--Grant/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed '/co08ld_040629/s/^Grant/--Grant/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed '/in01ld_040826/s/^Grant/--Grant/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed '/fund_sm1/s/^Grant/--Grant/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed '/fund_sm2/s/^Grant/--Grant/g' < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed -e "248 i\ Grant all to fund" < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql

sed -e "249 i\ go " < ${WORK_PATH}/$1/all_grant_revoke_user.sql > ${WORK_PATH}/$1/all_grant_revoke_user1.sql
rm ${WORK_PATH}/$1/all_grant_revoke_user.sql
mv ${WORK_PATH}/$1/all_grant_revoke_user1.sql all_grant_revoke_user.sql
