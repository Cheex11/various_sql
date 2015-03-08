
--insert class into each business account
insert into phonecode_class_join_with_account_GIT (frn_accountid_GIT,frn_agentcode_GIT)
select distinct(l.accounts_table_GIT), 3302
from phonecode_class_table_GIT pcp
	inner join phonecode_table_GIT on p.phonecode_tableid_GIT = pcp.frn_phonecode_tableid_GIT
	inner join accountid_GIT l on p.frn_accountid_GIT = l.accounts_table_GIT
	inner join phonecode_class pc on pcp.frn_agentcode_GIT = pc.phonecode_classid
where pc.phonecode_class_Name_GIT = 'pcc'
and l.masteraccountid_GIT = 555_GIT
	and p.still_active_GIT = 1


--insert class for each phonecode
insert into phonecode_class_table_GIT(frn_phonecode_tableid_GIT,frn_agentcode_GIT)
select phonecode_tableid_GIT, 3302 
from phonecode_class_table_GIT pcp
	inner join phonecode_table_GIT on p.phonecode_tableid_GIT = pcp.frn_phonecode_tableid_GIT
	inner join accountid_GIT l on p.frn_accountid_GIT = l.accounts_table_GIT
	inner join phonecode_class pc on pcp.frn_agentcode_GIT = pc.phonecode_classid
where pc.phonecode_class_Name_GIT = 'pcc'
and l.masteraccountid_GIT = 555_GIT
	and p.still_active_GIT = 1


