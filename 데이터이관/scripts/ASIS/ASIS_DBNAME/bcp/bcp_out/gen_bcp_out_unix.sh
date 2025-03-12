#!/usr/bin/ksh
#
#  [ Usage : sh bcp_out_gen.sh sa_password [DB_name] ]
#
echo "start time =======>`date`" >> `echo $0 | cut -d'.' -f1`_`date +%y%m%d`.log 
if  [ $# -lt 1 ]
then
	echo ''
	echo 'Usage : sh bcp_out_gen.sh sa_password [DB_name] '
	echo ''
	exit
fi
if  [ $# -eq 2 ]
then
	P_DB=$2
fi

# define variables
. ../../info.sh

BCP_WORK_PWD=$1

if [ -z $P_DB ]
then
	check_flag="T"
else
	check_flag="F"
fi

if [ ! -d $BCP_DATA_DIR ]
then
	mkdir $BCP_DATA_DIR
fi

#
# User define Function (UDF)
#
# Get DB name from ASE
get_DBname(){
isql -U$BCP_WORK_USER -P$BCP_WORK_PWD -S$BCP_WORK_SERVER -J${BCP_WORK_CHARSET} -b <<_EOF > tmp_DB
set nocount on
go
select name,dbid from master..sysdatabases
where dbid > 3 and dbid < 31000 and status3 & 256 <> 256
order by dbid
go
_EOF
}

# Get Table name from DB
get_Tablename(){
isql -U$BCP_WORK_USER -P$BCP_WORK_PWD -S$BCP_WORK_SERVER -J${BCP_WORK_CHARSET} -b <<_EOF > tmp_Table
set nocount on
go
use $DB_name
go
select ltrim(rtrim(name)) from $DB_name..sysobjects
where type='U'
order by name
go
_EOF
}

#################################################
#20120801 정현중 추가
#################################################

#################################################
# Get Table name with Text/Image columns from DB#
#################################################
get_Tablename_text_image(){
isql -U$BCP_WORK_USER -P$BCP_WORK_PWD -S$BCP_WORK_SERVER -J${BCP_WORK_CHARSET} -b <<_EOF > tmp_Table_text_image
set nocount on
go
use $DB_name
go
select ltrim(rtrim(name)) from $DB_name..sysobjects
where type='U' and sysstat & 8192 = 8192
order by name
go
_EOF
}
#################################################
# Get Table name with identity columns from DB
#################################################
get_Tablename_idendity(){
isql -U$BCP_WORK_USER -P$BCP_WORK_PWD -S$BCP_WORK_SERVER -J${BCP_WORK_CHARSET} -b <<_EOF > tmp_Table_identity
set nocount on
go
use $DB_name
go
select ltrim(rtrim(name)) from $DB_name..sysobjects
where type='U' and sysstat2 & 64 = 64
order by name
go
_EOF
}
#################################################
# Get Table name with enctypted columns from DB
#################################################
get_Tablename_encrypted(){
isql -U$BCP_WORK_USER -P$BCP_WORK_PWD -S$BCP_WORK_SERVER -J${BCP_WORK_CHARSET} -b <<_EOF > tmp_Table_encrypted
set nocount on
go
use $DB_name
go
select ltrim(rtrim(a.name)) from $DB_name..sysobjects a, syscolumns b where a.type="U" and a.id=b.id and b.status2 & 128 = 128 order by a.name
go
_EOF
}

#################################################
#End
#################################################

# Get a word from line
processLine(){
  line="$@" # get all args
  #  just echo them, but you may need to customize it according to your need
  # for example, F1 will store first field of $line, see readline2 script
  # for more examples
  F1=`echo $line | awk '{ print $1 }'`
  #echo $F1
}












get_DBname

while read line
do
	DB_name="`echo $line | awk '{print $1}'`"

	# only a DB gen if have dbname parameter 
	if [[ $check_flag = "F" && $DB_name != $P_DB ]]
	then
		continue
	fi

	echo "--- bcp gen for $DB_name  ----"
	echo "--- bcp gen for $DB_name  ----"     >> `echo $0 | cut -d'.' -f1`_`date +%y%m%d`.log

	#DB directory check
	if [ ! -d $BCP_WORK_DIR/$DB_name ]
	then
		mkdir $BCP_WORK_DIR/$DB_name
	fi

	#bcp out directory check
	if [ ! -d $BCP_DATA_DIR/$DB_name ]
	then
		mkdir $BCP_DATA_DIR/$DB_name
	fi





	get_Tablename "$DB_name"
	get_Tablename_text_image "$DB_name"

	while read line1
	do
		processLine "$line1"	
		TABLE_name=$F1

		#bcp script file check
		if [ -f $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh ]
		then
			rm $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh
		fi

		# start time log
                tmp_time='echo "Start Time : `date +%y/%m/%d_%H:%M:%S` "' 
		echo "$tmp_time > $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.log" > $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh
		echo "" >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh

		# bcp script
		#-------------------
		# should check -E option when bcp in identity column
		#-------------------
		#################################################
		#20120801 정현중 추가
		#################################################
							
		BCP_STRING="bcp $DB_name..$TABLE_name out $BCP_DATA_DIR/$DB_name/$TABLE_name.dat -U$BCP_SCRIPT_USER -P$BCP_SCRIPT_PWD -S$BCP_SCRIPT_SERVER -c -t'${COLUMN_DELIMITER}' -r'${ROW_DELIMITER}' -J${BCP_SCRIPT_CHARSET} -e $BCP_WORK_DIR/$DB_name/$TABLE_name.err -A${MAX_NET_PACKET_SIZE}"

		while read line2
		do
			TABLE_name2=$line2
			#echo $TABLE_name
			#echo $TABLE_name2
			if [ $TABLE_name == $TABLE_name2 ]
			then
				BCP_STRING="${BCP_STRING} -T${MAX_TEXT_SIZE}"
			fi	

		done		< tmp_Table_text_image

	#	get_Tablename_idendity "$DB_name"
	#	cat tmp_Table_identity | \
	#	while read line3
	#	do
	#		processLine "$line3"
	#		TABLE_name3=$F1
	#		#echo $TABLE_name
	#		#echo $TABLE_name2
	#		if [ $TABLE_name = $TABLE_name3 ]
	#		then
	#			BCP_STRING=`echo "$BCP_STRING -E"`
	#		fi	
#		done
#
		#get_Tablename_encrypted "$DB_name"
		#cat tmp_Table_encrypted | \
		#while read line4
		#do
	#		processLine "$line4"
	#		TABLE_name4=$F1
	#		#echo $TABLE_name
	#		#echo $TABLE_name2
	#		if [ $TABLE_name = $TABLE_name4 ]
	#		then
	#			BCP_STRING=`echo "$BCP_STRING -C"`
	#		fi	
	#	done		
	#
		echo "$BCP_STRING >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.log" >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh

		#################################################
		#End
		#################################################


		echo "" >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh

		# end time log
                tmp_time='echo "End Time : `date +%y/%m/%d_%H:%M:%S` "' 
		echo "$tmp_time >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.log" >> $BCP_WORK_DIR/$DB_name/bcp_out_$TABLE_name.sh

	done             < tmp_Table
done                     < tmp_DB

rm tmp_DB
rm tmp_Table
#################################################
#20120801 정현중 추가
#################################################
rm tmp_Table_text_image
#rm tmp_Table_identity
#rm tmp_Table_encrypted
#################################################
#End
#################################################
echo "end   time =======>`date`" >> `echo $0 | cut -d'.' -f1`_`date +%y%m%d`.log

cd $BCP_WORK_DIR/FUND_DB
ls -l bcp_out*.sh | awk '{print "sh " $9}' > ./ALL_BCP_OUT.sh
cd ../EXCB
ls -l bcp_out*.sh | awk '{print "sh " $9}' > ./ALL_BCP_OUT.sh
cd ../FUND_BK
ls -l bcp_out*.sh | awk '{print "sh " $9}' > ./ALL_BCP_OUT.sh
cd ../readers
ls -l bcp_out*.sh | awk '{print "sh " $9}' > ./ALL_BCP_OUT.sh
cd ../FUND2
ls -l bcp_out*.sh | awk '{print "sh " $9}' > ./ALL_BCP_OUT.sh
