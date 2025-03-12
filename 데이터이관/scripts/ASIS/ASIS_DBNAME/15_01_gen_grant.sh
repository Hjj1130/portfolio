. ./info.sh

cd ./grant

sh gen_grant.sh USERDB1 
sh gen_grant.sh USERDB2 
sh gen_grant.sh USERDB3 
sh gen_grant_USERDB4.sh USERDB4 
sh gen_grant_USERDB5.sh USERDB5 

cp -R USERDB1 USERDB2 USERDB3 USERDB4 USERDB5 /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/grant
