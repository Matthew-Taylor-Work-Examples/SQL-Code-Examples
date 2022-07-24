/* Utilization & Occupancy Info */
SELECT CallDate
	,Site_Location
	,CASE WHEN [Site_Location] in ('BEL-SA','GUA-SA','SPS-SA','BZE-SA')
        THEN 'Allied-Sales'
        WHEN [Site_Location] in ('SAL-SA','MGA-SA')
        THEN 'Focus-Sales'
		WHEN [Site_Location] in ('UTA-SA')
        THEN 'Lehi-Sales'
		WHEN [Site_Location] in ('BEL-SU','GUA-SU','SPS-SU')
        THEN 'Allied-Support'
		WHEN [Site_Location] in ('UTA-SU')
        THEN 'Lehi-Support'
        ELSE Site_Location END AS Dept
    ,Dept as Dept1
	,CASE WHEN Site_Location in ('MGA-SA','SAL-SA')
		then SUM(ISNULL(Staffed,0))-(sum(ISNULL(Lunch,0))+sum(ISNULL(Break_,0)))
	Else  SUM(ISNULL(Staffed,0)) END as Staffed
	,SUM(ISNULL(WrapUp,0) + ISNULL(Talk,0) + ISNULL(Hold,0) + ISNULL(Outbound_Talk,0)) as HandleTime
	,SUM(ISNULL(WrapUp,0) + ISNULL(Talk,0) + ISNULL(Hold,0) + ISNULL(Outbound_Talk,0) + ISNULL(Idle,0)) as Available

  FROM [dbo].[Broadsoft_inContact]

  WHERE CallDate = '6/14/2016'
  AND Dept in ('Sales','Support')

  GROUP BY CallDate
	,Dept
	,Site_Location

HAVING sum(Inbound_Calls) >0