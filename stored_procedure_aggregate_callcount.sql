USE [callmeasurement]
GO
/****** Object:  StoredProcedure [dbo].[git_procedure_name]    Script Date: 2/20/2015 2:58:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Jian>
-- Create date: <1/08/2015>
-- Description:	<maintain 6 month aggregated data for reporting purposes. hf project 1967>
-- =============================================
ALTER PROCEDURE  [dbo].[git_procedure_name]
	
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM table_I_am_aggregating_git WHERE date_git<DATEADD(month, -6, GETDATE());
	
	--update hco count
	WITH CTE AS (
		SELECT account_number_git, date_git, frn_option_git_id, frn_branch_option_git_id, COUNT(distinct call_count_git_id) AS total_call_count_git
		FROM xcall_long_hcat
			INNER JOIN xcall_long c ON callid=call_count_git_id AND spamrating=0 AND frn_option_git_id not in (62,66,73)
			INNER JOIN xdnis on dnisid=cf_frn_dnisid 
		GROUP BY account_number_git, c.date_git, frn_option_git_id, frn_branch_option_git_id
	)
	UPDATE agg SET total_call_count_git = c.total_call_count_git
	FROM CTE c
		INNER JOIN table_I_am_aggregating_git agg ON agg.accountid_GIT = account_number_git AND agg.hcatid = frn_option_git_id 
									AND agg.hcat_optionid = frn_branch_option_git_id AND agg.date_git = c.date_git 
	WHERE agg.total_call_count_git <> c.total_call_count_git;
	
	--new records
	--hco count
	INSERT INTO table_I_am_aggregating_git(accountid_GIT, date_git, hcatid, hcat_optionid, total_call_count_git, log_datetime)
	SELECT account_number_git, c.date_git, frn_option_git_id, frn_branch_option_git_id, COUNT(distinct call_count_git_id), GETDATE()
	FROM xcall_long_hcat
		INNER JOIN xcall_long c ON callid=call_count_git_id AND spamrating=0 AND frn_option_git_id not in (62,66,73)
		INNER JOIN xdnis on dnisid=cf_frn_dnisid
		LEFT JOIN table_I_am_aggregating_git agg ON agg.accountid_GIT = account_number_git AND agg.date_git = c.date_git 
										AND agg.hcatid = frn_option_git_id AND agg.hcat_optionid = frn_branch_option_git_id 
	WHERE agg.accountid_GIT IS NULL
	GROUP BY account_number_git, c.date_git, frn_option_git_id, frn_branch_option_git_id;

	--connected_calls_GIT count
	WITH CTE AS (
		SELECT account_number_git, date_git, ISNULL(COUNT(distinct CASE WHEN frn_xcall_dispositionid=1 THEN callid END),0) AS connected_calls_GIT, 
				ISNULL(COUNT(distinct callid), 0) AS all_the_git_calls, ISNULL(AVG(cast(pickup_time as numeric)),0) AS time_to_pickup_avg_GIT
		FROM xcall_long c
			INNER JOIN xcall_long_details cd ON cd.call_count_git_id = c.callid
			INNER JOIN xdnis on dnisid=cf_frn_dnisid AND spamrating=0
		GROUP BY account_number_git, c.date_git
	)
	UPDATE agg SET connected_calls_GIT = c.connected_calls_GIT, all_the_git_calls = c.all_the_git_calls, time_to_pickup_avg_GIT = c.time_to_pickup_avg_GIT
	FROM CTE c
		INNER JOIN table_I_am_aggregating_git agg ON agg.accountid_GIT = account_number_git AND agg.date_git = c.date_git AND agg.hcatid IS NULL
	WHERE agg.connected_calls_GIT <> c.connected_calls_GIT OR agg.all_the_git_calls <> c.all_the_git_calls OR agg.time_to_pickup_avg_GIT <> c.time_to_pickup_avg_GIT;
	
	--new records
	--connected_calls_GIT /all calls count
	INSERT INTO table_I_am_aggregating_git(accountid_GIT, date_git, connected_calls_GIT, all_the_git_calls, time_to_pickup_avg_GIT)
	SELECT account_number_git, c.date_git, ISNULL(COUNT(distinct CASE WHEN frn_xcall_dispositionid=1 THEN callid END),0), 
		ISNULL(COUNT(distinct callid), 0), ISNULL(AVG(cast(pickup_time as numeric)),0)
	FROM xcall_long c 
		INNER JOIN xcall_long_details cd ON cd.call_count_git_id = c.callid
		INNER JOIN xdnis on dnisid=cf_frn_dnisid AND spamrating=0
		LEFT JOIN table_I_am_aggregating_git agg ON agg.accountid_GIT = account_number_git AND agg.date_git = c.date_git AND agg.hcatid IS NULL 
	WHERE agg.accountid_GIT IS NULL
	GROUP BY account_number_git, c.date_git


