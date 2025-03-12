. ./info.sh

cd ./RI

sh gen_ri.sh USERDB1 
sh gen_ri.sh USERDB2 
sh gen_ri.sh USERDB3 
sh gen_ri.sh USERDB4 
sh gen_ri.sh USERDB5 

cp -R USERDB1 USERDB2 USERDB3 USERDB4 USERDB5 /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/RI
