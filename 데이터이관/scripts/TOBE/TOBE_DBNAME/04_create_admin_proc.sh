. ./info.sh

isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_dbspace.sql"
isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_dbsize.sql"
isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_helprotect_dbname_15.sql"
isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_identity.sql"
isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_spaceusedall.sql"
isql -U${TOBE_DB_USER} -w200 -P${TOBE_DB_PWD} -S${TOBE_DB_SERVER} -i"../../../../07_USER_DEFINE_PROC/sp_spaceusedall_dbname15.sql"
