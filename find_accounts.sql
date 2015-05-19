select 
		master_account_number_GIT,
		account_name_GIT,
		sum(total_min_GIT) as total_minutes,
		sum(case when d.outbound_GIT = 1 then total_min_GIT end) as outbound_minutes,
		sum(case when d.outbound_GIT = 0 then total_min_GIT end) as inbound_minutes,
		last_login_GIT as last_login,
		name_GIT,
		role_GIT,
		phone_GIT
from xcall_long xl
		inner join phone_info_GIT d 
			on xl.cf_frn_phone_info_GITid = d.phone_info_GITid
		inner join accounts_GIT l 
			on d.add_accounts_GITid = l.accounts_GITid 
		inner join users_GIT u 
			on u.frn_accounts_GITid = l.accounts_GITid 
		inner join product_GIT_accounts_GIT hl
			on l.accounts_GITid = hl.frn_accounts_GITid and frn_product_GITid = 1
		left join go.dbo.accounts_GIT_contact lc 
			on l.accounts_GITid = lc.frn_accounts_GITid 
		LEFT join go.dbo.accounts_GIT_phone_GIT lcp
			on lc.accounts_GIT_contactid = lcp.frn_accounts_GIT_contactid 
where tz_date between '20150401' and '20150430'
	and u.last_login_GIT = (select max(u.last_login_GIT)
						  from users_GIT u
						  where l.accounts_GITid = u.frn_accounts_GITid)
	and u.last_login_GIT > '20150415'	
	and lc.lcactive = 1
group by	master_account_number_GIT,
			account_name_GIT,
			last_login_GIT,
			name_GIT,
			role_GIT,
			phone_GIT
having sum(total_min_GIT) > 5000
order by master_account_number_GIT, account_name_GIT