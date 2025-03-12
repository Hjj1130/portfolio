cd ./procs
        egrep "CREATING Stored" EXCB.log | awk -F' ' '{print $6}' | awk -F'"' '{print $2}'
        egrep "CREATING Stored" readers.log | awk -F' ' '{print $6}' | awk -F'"' '{print $2}'
        egrep "CREATING Stored" FUND_DB.log | awk -F' ' '{print $6}' | awk -F'"' '{print $2}'
        egrep "CREATING Stored" FUND_BK.log | awk -F' ' '{print $6}' | awk -F'"' '{print $2}'
        egrep "CREATING Stored" FUND2.log | awk -F' ' '{print $6}' | awk -F'"' '{print $2}'
