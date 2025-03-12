cd ./bcp/bcp_out/USERDB4
sh ALL_BCP_OUT_1.sh &
sh ALL_BCP_OUT_2.sh &

cd ../USERDB1
sh ALL_BCP_OUT.sh &

cd ../USERDB5
sh ALL_BCP_OUT.sh &

cd ../USERDB3
sh ALL_BCP_OUT.sh &

cd ../USERDB2
sh ALL_BCP_OUT.sh &
