insert into account_join_git (frn_accountid_GIT, frn_groupid_git)
SELECT accountID_git, 56
FROM   accounts_table_git l
	inner join groups_with_accounts_table_git hl on l.accountID_git = hl.frn_accountid_GIT
WHERE  NOT EXISTS (SELECT * 
                   FROM   account_join_git lgj
                   WHERE  l.accountID_git = lgj.frn_accountid_GIT)
	and l.isactive = 1
	and hl.frn_groups_withid = 1