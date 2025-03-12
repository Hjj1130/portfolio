#!/usr/bin/sh
SERVERNM="HEQ"
LOGINNM="sapsa"
LOGINPWD=$1

isql -U${LOGINNM} -P${LOGINPWD} -S${SERVERNM} -b -w500 -X <<_!  >> ./`echo $0 | cut -d'.' -f1`_${C_DATE}.log

set nocount on
go

print "LOG Space"

select convert(char(32), getdate(), 139), convert(char(16), db_name(d.dbid))
+ "|Log_Total_MB=" + convert(char(9), ceiling(sum(case when u.segmap = 4 then u.size/1048576.*@@maxpagesize end)))
+ "|Free_MB=" +
convert(char(12),
(convert(numeric(8,1),
(lct_admin("logsegment_freepages",d.dbid) - 1.0 * lct_admin("reserved_for_rollbacks",d.dbid)) /1048576.*@@maxpagesize
)))
+ "|Used=" +
rtrim(convert(char(7),
(convert(numeric(12,2),
(100 * (1 - 1.0 *
(lct_admin("logsegment_freepages",d.dbid) - 1.0 * lct_admin("reserved_for_rollbacks",d.dbid))
/ sum(case when u.segmap in (4, 7) then u.size end)))
)))) + "%"
from master..sysdatabases d, master..sysusages u
where u.dbid = d.dbid  and d.status not in (256,4096)
group by d.dbid
having (sum(case when u.segmap = 4 then u.size/1048576.*@@maxpagesize end)) != NULL
order by db_name(d.dbid)
go

print "DATA Space"

select convert(char(32), getdate(), 139), convert(char(16), db_name(d.dbid))
+ "|Data_Total_MB=" + convert(char(9), ceiling (sum(case when u.segmap in (3,7,11) then u.size/1048576.*@@maxpagesize end )))
+ "|Free_MB=" + convert(char(14), (convert(numeric(8,1),
           ((sum(case when u.segmap in (3,7,11)  then u.size/1048576.*@@maxpagesize end ))) - (sum(case when u.segmap in (3,7,11) then size
           - curunreservedpgs(u.dbid, u.lstart, u.unreservedpgs) end)/1048576.*@@maxpagesize))))
+ "|Used=" + rtrim(convert(char(9), (convert(numeric(12,2),
           100 * (1 - 1.0 * sum(case when u.segmap in (3,7,11) then curunreservedpgs(u.dbid, u.lstart, u.unreservedpgs) end) / sum(case when u.segmap in (3,7,11) then u.size end))))))
+ "%"
+ "|Free_Pages=" + convert(char(14), (convert(numeric(8,0),
           ((sum(case when u.segmap in (3,7,11) then u.size/1.0 end ))) - (sum(case when u.segmap in (3,7,11) then size
           - curunreservedpgs(u.dbid, u.lstart, u.unreservedpgs) end)/1.0))))

+ "|30%_Free_Pages_calc_threshold=" + convert(char(9), ceiling(0.30 * (sum(case when u.segmap in (3,7,11) then u.size/1.0 end ))))
from master..sysdatabases d, master..sysusages u
where u.dbid = d.dbid  and d.status not in (256,4096)
group by d.dbid
order by db_name(d.dbid)
go

_!