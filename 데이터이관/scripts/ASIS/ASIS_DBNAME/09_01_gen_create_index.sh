. ./info.sh

cd ./index

sh gen_index.sh USERDB1 
sh gen_index.sh USERDB2 
sh gen_index.sh USERDB3 
sh gen_index_USERDB4.sh USERDB4 
sh gen_index_USERDB5.sh USERDB5

cp -R USERDB1 USERDB2 USERDB3 USERDB4 USERDB5 /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/index 
