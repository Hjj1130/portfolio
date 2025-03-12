. ./info.sh

cd ./trigger

sh gen_trigger.sh USERDB1 
sh gen_trigger.sh USERDB2 
sh gen_trigger.sh USERDB3 
sh gen_trigger_USERDB4.sh USERDB4 
sh gen_trigger_USERDB5.sh USERDB5 

cp -R USERDB1 USERDB2 USERDB3 USERDB4 USERDB5 /app/sybase/NO_DEL/03_ASE_MIG/D_DAY/TOBE/TOBE_DBNAME/trigger
