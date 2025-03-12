#!/bin/ksh
#
#  [ Usage : update_stat_gen.sh sa_password ]
#
if  [ $# -lt 1 ]
then
	echo ''
	echo "Usage : gen_update_stat.sh sa_password [DB_name] "
	echo ''
	exit
fi

if [ $# -eq 2 ]
then
	P_DB=$2
fi

# define variables
. ../info.sh

#update statistics script dir
CUR_DIR=`pwd`

if [ -z $P_DB ]
then
        check_flag="T"
else
        check_flag="F"
fi

GEN_PWD=$1

#
# User define Function (UDF)
#
# Get DB name from ASE
get_DBname(){
isql -U$TOBE_DB_USER -P$GEN_PWD -S$TOBE_DB_SERVER -w2560 -b <<_EOF > tmp_DB
set nocount on
go
select name,dbid from master..sysdatabases
where dbid > 3 and dbid < 31000 and status3 & 256 = 0 
order by dbid
go
_EOF
}

# Get Table name from DB
get_Tablesize(){
isql -U$TOBE_DB_USER -P$GEN_PWD -S$TOBE_DB_SERVER -w2560 -b <<_EOF > tmp_1
set nocount on
go
use $DB_name
go
exec sp_spaceusedall
go
_EOF
sed '/return status = 0/d' tmp_1 > tmp_Tablesize
rm tmp_1
}

# Get a word from line
processLine(){
  line="$@" # get all args
  #  just echo them, but you may need to customize it according to your need
  # for example, F1 will store first field of $line, see readline2 script
  # for more examples
  F1=`echo $line | awk '{ print $1 }'`
  F2=`echo $line | awk '{ print $2 }'`
  #echo $F1
}

get_DBname

while read line
do
        processLine "$line"
	DB_name=$F1

	# only a DB gen if have dbname parameter 

	if [[ $check_flag == "F" && $DB_name != $P_DB ]]
	then
		continue
	fi

	#DB directory check
        if [ ! -d $CUR_DIR/$DB_name ]
        then
                mkdir $CUR_DIR/$DB_name
        fi

	echo "--- update stat gen for $F1  ----"
	echo "--- update stat gen for $F1  ----"                                                           >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh

	#update statistics file check
	if [  -f $CUR_DIR/$DB_name/update_stat_$DB_name.sh ]
	then
		rm $CUR_DIR/$DB_name/update_stat_$DB_name.sh
	fi

	#header gen for each DB
	echo "isql -U$TOBE_DB_USER -P$TOBE_DB_PWD -S$TOBE_DB_SERVER -b <<_EOF > update_stat_$DB_name.log " >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
	echo "set nocount on"                                                                              >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
	echo "go"                                                                                          >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
	echo "use $DB_name"                                                                                >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
	echo "go"                                                                                          >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh

	get_Tablesize "$DB_name"

	while read line1
	do
		processLine "$line1"	
		TABLE_name=$F1
		ROW_CNT=$F2

		#Table name print
		echo "print '' "                                                                           >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
		echo "print '-- Table: $TABLE_name  Row_count: $ROW_CNT --' "                              >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
		echo "go" >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh


		# start time log
		echo "select 'Start Time : '+ convert(varchar(30), getdate(),108)"                         >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
		echo "go"                                                                                  >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh


		if [ $DB_name = "USERDB5" ] || [ $DB_name = "USERDB4" ]
		then
			echo "update index statistics fund.$TABLE_name with hashing" >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh          >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
			echo "go"                                                                                                     >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
		else
			echo "update index statistics $TABLE_name with hashing" >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh          >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
			echo "go"                                                                                                     >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh

		fi

		# end time log
		echo "select 'End Time : '+ convert(varchar(30), getdate(),108)"                                              >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
		echo "go"                                                                                                     >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh

	done                                     < tmp_Tablesize
	echo "_EOF"                                                                                                           >> $CUR_DIR/$DB_name/update_stat_$DB_name.sh
done                                             < tmp_DB

rm tmp_DB
rm tmp_Tablesize
