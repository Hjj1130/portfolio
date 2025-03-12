cd ./index

ls -F  | grep / | \
while read line
do
        cd $line
        echo "------ $line ------"
        egrep "\-\- " *.log | awk -F' ' '{print $2}' 
	cd ..
done
