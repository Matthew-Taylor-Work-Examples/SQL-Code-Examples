SELECT calls.CallType
	,calls.CallDate as SQLDate
	,sum(calls.CallsOffered) as CallsOffered
	,sum(calls.CallsOffered-isnull(CallsAbandoned,0)) as CallsHandled
	,case when sum(aht.AHT) IS NULL
		THEN lead(sum(aht.AHT)) OVER (ORDER BY calls.CallDate) 
		ELSE sum(aht.AHT) END AS AHT
	,DATENAME(dw,calls.CallDate) as [DayofWeek]

FROM Interval_Calls calls
LEFT JOIN Interval_AHT aht on calls.CallDate = aht.CallDate and calls.interval = aht.interval and calls.CallType = aht.Dept

WHERE calls.CallDate >= '1/1/2012'

GROUP BY calls.CallDate
	,DATENAME(dw,calls.CallDate)
	,calls.CallType

ORDER BY calls.CallDate