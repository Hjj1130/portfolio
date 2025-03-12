cd ./bcp/bcp_in

ls -F  | grep / | \
while read line
do
        cd $line
        echo "------ $line ------"
        egrep "Msg|fail|Message|error|Error" *.log
        cd ..
done
