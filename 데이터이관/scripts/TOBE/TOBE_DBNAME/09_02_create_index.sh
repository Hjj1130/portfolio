. ./info.sh

#sleep 3600

cd ./index

sh create_index.sh USERDB1 &
sh create_index.sh USERDB2 &
sh create_index.sh USERDB3 &
sh create_index.sh USERDB4 &
sh create_index.sh USERDB5 &
sh create_v_tax_index.sh USERDB4 &
sh create_v_tax_index.sh USERDB5 &
sh cr_index_ddl_tuning.sh
