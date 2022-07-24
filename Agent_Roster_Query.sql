SELECT cast(b2.Broadsoft_ID as int) as Broadsoft_ID
      ,Name
      ,Site_Location
	  ,Dept
	  ,CASE WHEN Site_Location like 'UTA%' then 'TravelPassGroup'
		WHEN Site_Location like 'SAL%' then 'Focus'
		WHEN Site_Location like 'MGA%' then 'Focus'
		WHEN Site_Location like 'GUA%' then 'Allied'
		WHEN Site_Location like 'SPS%' then 'Allied'
		WHEN Site_Location like 'BEL%' then 'Allied'
		WHEN Site_Location like 'BZE%' then 'Allied'
		WHEN Site_Location like 'MEX%' then 'Allied'
		Else Site_Location END as Partner
	  ,CASE WHEN Site_Location like 'UTA%' then 'TravelPassGroup'
		WHEN Site_Location like 'SAL%' then 'El Salvador'
		WHEN Site_Location like 'MGA%' then 'Nicaragua'
		WHEN Site_Location like 'GUA%' then 'Guatemala'
		WHEN Site_Location like 'SPS%' then 'Honduras'
		WHEN Site_Location like 'BEL%' then 'Belize Placencia'
		WHEN Site_Location like 'BZE%' then 'Belize City'
		WHEN Site_Location like 'MEX%' then 'Mexico City'
		Else Site_Location END as Full_Site_Name

FROM Broadsoft_Data.dbo.Broadsoft_inContact b1
JOIN (SELECT b.Broadsoft_ID, max(CallDate) as CallDate
		FROM dbo.Broadsoft_inContact b
		GROUP BY b.Broadsoft_ID) as b2 on b1.Broadsoft_ID = b2.Broadsoft_ID and b1.CallDate = b2.CallDate


WHERE b1.Site_Location <> ''
  
GROUP BY b1.Name
      ,b2.Broadsoft_ID
      ,b1.Site_Location
      ,b1.Dept

ORDER BY Broadsoft_ID