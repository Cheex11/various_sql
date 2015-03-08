USE [archive_GIT]
GO

/****** Object:  View [dbo].[vwXCall_2013_2014_2015]    Script Date: 3/3/2015 2:02:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER VIEW [dbo].[call_data_GIT_2013_2014_2015]
AS
SELECT     [call_id_GIT], [the_date_GIT], [phone_id_GIT], [extension_GIT], [dialout_GIT], [callerID_GIT], [isitspam_GIT], [min_GIT], [ph_code_GIT], 
                      [call_rating_GIT],[frn_zipcode_GIT], [date_time_GIT]
FROM         call_info_2015_GIT
UNION
SELECT     [call_id_GIT], [the_date_GIT], [phone_id_GIT], [extension_GIT], [dialout_GIT], [callerID_GIT], [isitspam_GIT], [min_GIT], [ph_code_GIT], 
                      [call_rating_GIT],[frn_zipcode_GIT], [date_time_GIT]
FROM         call_info_2014_GIT
UNION
SELECT     [call_id_GIT], [the_date_GIT], [phone_id_GIT], [extension_GIT], [dialout_GIT], [callerID_GIT], [isitspam_GIT], [min_GIT], [ph_code_GIT], 
                      [call_rating_GIT],[frn_zipcode_GIT], [date_time_GIT]
FROM         call_info_2013_GIT



GO


