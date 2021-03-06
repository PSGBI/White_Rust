

Select x.*,
x.Part_UnitCost*x.IssueQTY as ExtendedCost
 from
(
select distinct
cast(n.ENTRYDATE as Date) as DateEntered
,case when n.COSTCENTERID='' or n.COSTCENTERID is null then '**Not Defined**' else n.COSTCENTERID end  as WorkCenterNum
,n.DEPARTMENTID as Department
,n.NCRNUM as NCR_Num
,n.NCRTYPE as IssueType
,n.CODE2 as ProblemDesc
,n.PARTNUM as PartNumber_NCR
,c.COLITM as PartNumber_JDE
,n.PARTDESC as PartDesc
,n.QTY as IssueQTY
,c.COUNCS/10000 as Part_UnitCost
from NCR n left join F4105_CostLedger c on c.COLITM=n.PARTNUM where n.CODE2='white rust' and c.COLEDG='07' and c.COUNCS is not null and c.COMCU='100'
) x