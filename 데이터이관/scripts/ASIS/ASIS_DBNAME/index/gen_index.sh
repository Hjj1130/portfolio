. ../info.sh

#!/bin/sh
#
#  [ Usage : gen_index.sh DB_name ]
#
if  [ $# -lt 1 ]
then
        echo ''
        echo 'Usage : gen_index.sh [DB_name] ' > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_`date +%Y%m%d`.out
        echo ''
        exit
fi

P_DB=$1

#

if [ -z $P_DB ]
then
        check_flag="T"
else
        check_flag="F"
fi

mkdir $1
cd $1

#check_flag="T"
#
# User define Function (UDF)
#
# Get DB name from ASE

get_DBname(){
isql -U${ASIS_DB_USER} -P${ASIS_DB_PWD} -S${ASIS_DB_SERVER} -b <<_! > tmp_DB
set nocount on
go
select name from master..sysdatabases
where dbid > 3 and dbid < 31000
and name not like 'temp%'
order by name
go
_!
}

# Get index gen from DB
get_Indexgen(){
isql -U$ASIS_DB_USER -P$ASIS_DB_PWD -S$ASIS_DB_SERVER -b -w256 <<_! > tmp_1
set nocount on
go
use $DB_name
go
exec sp_index_gen
go
_!
sed '/return status = 0/d' tmp_1 > tmp_Index
rm tmp_1
}

# Get a word from line
processLine(){
  line="$@" # get all args
  #  just echo them, but you may need to customize it according to your need
  # for example, F1 will store first field of $line, see readline2 script
  # for more examples
  F1=`echo $line`
  F2=`echo $line | awk '{ print $1 }'`
  #echo $F1
}

get_DBname

cat tmp_DB  | \
while read line
do
        processLine "$line"
        DB_name=$F1

        # only a DB gen if have dbname parameter 
        if [[ $check_flag = "F" && $DB_name != $P_DB ]]
        then
                continue
        fi

        echo "--- index gen for $F1  ----"

        #update statistics file check
        if [  -f $WORK_PATH/$1/create_index_$DB_name.sh ]
        then
                rm $WORK_PATH/$1/create_index_$DB_name.sh
        fi

        #header gen for each DB
        echo "isql -U$TOBE_DB_USER -P$TOBE_DB_PWD -S$TOBE_DB_SERVER -b -w256 <<_EOF > create_index_$DB_name.log" >> $WORK_PATH/$1/create_index_$DB_name.sh
        echo "use $DB_name" >> $WORK_PATH/$1/create_index_$DB_name.sh
        echo "go" >> $WORK_PATH/$1/create_index_$DB_name.sh
        #echo "dbcc traceon(549)" >> $WORK_PATH/$1/create_index_$DB_name.sh
        #echo "go" >> $WORK_PATH/$1/create_index_$DB_name.sh

        get_Indexgen "$DB_name"
        cat tmp_Index | \
        while read line1
        do
                processLine "$line1"
                INDEX_script=$F1

                # Start Time
                #if [[ $F2 == "alter" || $F2 == "create" ]]
                if [[ $F2 = "alter" || $F2 = "create" ]]
                then
                        echo "select 'Start Time : '+ convert(varchar(30), getdate(),108)" >> $WORK_PATH/$1/create_index_$DB_name.sh
                        echo "go" >> $WORK_PATH/$1/create_index_$DB_name.sh
                else
                        echo "" >> $WORK_PATH/$1/create_index_$DB_name.sh
                fi

                # update statistics gen  script
                echo "$INDEX_script" >> $WORK_PATH/$1/create_index_$DB_name.sh
                echo "go" >> $WORK_PATH/$1/create_index_$DB_name.sh

                # End Time
                #if [[ $F2 == "alter" || $F2 == "create" ]]
                if [[ $F2 = "alter" || $F2 = "create" ]]
                then
                        echo "select '  End Time : '+ convert(varchar(30), getdate(),108)" >> $WORK_PATH/$1/create_index_$DB_name.sh
                        echo "go" >> $WORK_PATH/$1/create_index_$DB_name.sh
                        echo "" >> $WORK_PATH/$1/create_index_$DB_name.sh
                fi

        done > ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_`date +%Y%m%d`.out
        echo "_EOF" >> $WORK_PATH/$1/create_index_$DB_name.sh
done >> ${WORK_PATH}/`echo $0 | cut -d'.' -f1`_${ASIS_DB_SERVER}_`date +%Y%m%d`.out

rm tmp_DB
rm tmp_Index

