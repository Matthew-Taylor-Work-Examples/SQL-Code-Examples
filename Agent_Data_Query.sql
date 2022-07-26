SELECT CallDate
	,DATENAME(dw, CallDate) AS [DayofWeek]
	,Name
	,Cast(Broadsoft_ID as int) as Broadsoft_ID
	,Site_Location
	,Dept
	,SUM(ISNULL(WrapUp,0)+ISNULL(Talk,0)+ISNULL(Hold,0)+ISNULL(Outbound_Talk,0)) AS HandleTime
	,SUM(ISNULL(WrapUp,0)) AS WrapUp
	,SUM(ISNULL(Talk,0)) AS Talk
	,SUM(ISNULL(Hold,0)) AS Hold
	,SUM(ISNULL(Idle,0)) AS Idle
	,SUM(ISNULL(Staffed,0))- (sum(ISNULL(Break_,0))+sum(ISNULL(Lunch,0))) as Staffed
	,SUM(ISNULL(Outbound_Talk,0)) AS Outbound_Talk
	,SUM(ISNULL(Inbound_Calls,0)) AS Inbound_Calls
	,SUM(ISNULL(Outbound_Calls,0)) AS Outbound_Calls
	,SUM(ISNULL(ShortDurationCalls,0)) AS ShortDurationCalls
	,SUM(ISNULL(BouncedCalls,0)) AS BouncedCalls

FROM Broadsoft_Data.dbo.Broadsoft_inContact

WHERE CallDate >='6/1/2016'
AND Dept = 'Sales'
AND Site_Location in ('SAL-SA','MGA-SA')


GROUP BY  CallDate
	,Name
	,Broadsoft_ID
	,Site_Location
	,Dept

ORDER BY CallDate, Name