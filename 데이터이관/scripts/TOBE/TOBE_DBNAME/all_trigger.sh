cd ./trigger

ls -F  | grep / | \
while read line
do
        cd $line
        echo "------ $line ------"
        egrep "CREATING Trigger" *.log | awk -F' ' '{print $5}' | awk -F'"' '{print $2}'
	cd ..
done
