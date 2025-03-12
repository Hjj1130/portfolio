#sleep 7500 

cd ./update_stat/USERDB1
sh update_stat_USERDB1.sh &

cd ../USERDB4
sh update_stat_USERDB4.sh &

cd ../USERDB2
sh update_stat_USERDB2.sh &

cd ../USERDB5
sh update_stat_USERDB5.sh &

cd ../USERDB3
sh update_stat_USERDB3.sh &
