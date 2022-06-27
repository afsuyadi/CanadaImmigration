/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Type]
      ,[Coverage]
      ,[OdName]
      ,[AREA]
      ,[AreaName]
      ,[REG]
      ,[RegName]
      ,[DEV]
      ,[DevName]
      ,[1980]
      ,[1981]
      ,[1982]
      ,[1983]
      ,[1984]
      ,[1985]
      ,[1986]
      ,[1987]
      ,[1988]
      ,[1989]
      ,[1990]
      ,[1991]
      ,[1992]
      ,[1993]
      ,[1994]
      ,[1995]
      ,[1996]
      ,[1997]
      ,[1998]
      ,[1999]
      ,[2000]
      ,[2001]
      ,[2002]
      ,[2003]
      ,[2004]
      ,[2005]
      ,[2006]
      ,[2007]
      ,[2008]
      ,[2009]
      ,[2010]
      ,[2011]
      ,[2012]
      ,[2013]
      ,[F44]
      ,[F45]
      ,[F46]
      ,[F47]
      ,[F48]
      ,[F49]
      ,[F50]
      ,[F51]
  FROM [Portofolio Project].[dbo].['Canada by Citizenship$']

  -- PART 1 : DATA PREPARATION

-- Drop Several Columns
alter table [Portofolio Project].[dbo].['Canada by Citizenship$']
Drop column F44, F45, F46, F47, F48, F49, F50, F51

alter table [Portofolio Project].[dbo].['Canada by Citizenship$']
Drop column AREA, REG, DEV, Type

alter table [Portofolio Project].[dbo].['Canada by Citizenship$']
Drop column type

select * from [Portofolio Project].[dbo].['Canada by Citizenship$']

Delete from [Portofolio Project].[dbo].['Canada by Citizenship$']
where AreaName = 'World'; 

-- Unpivot the year column

Create view canadav2 as
select Coverage, OdName, AreaName, RegName, DevName, Year, NumOfImm
from [Portofolio Project].[dbo].['Canada by Citizenship$']
unpivot (

	NumOfImm for year in ([1980], [1981], [1982], [1983], [1984], [1985],[1986],[1987],[1988],[1989],[1990],[1991],[1992],[1993],
	[1994],[1995],[1996],[1997],[1998],[1999],[2000],[2001],[2002],[2003],[2004],[2005],[2006],[2007],[2008],[2009],[2010],[2011],
	[2012],[2013]
	)
) as imm

select * from canadav2

  -- PART 2 : DATA UNDERSTANDING (UNIVARIATE ANALYSIS)

  -- Average immigrant per year
  Select avg(y.TotImm) AverageImmigrant from (
		select sum(NumOfImm) TotImm
		from canadav2
		group by year) y
 
 -- Top 10 year with Highest Immigrants
Select top 10 year, sum(NumOfImm) TotalOfImmigrants from canadav2
group by year
order by sum(NumOfImm) Desc

-- Total Immigrant per Continent
Select AreaName, sum(NumOfImm) TotalOfImmigrant from canadav2
group by AreaName
Order by sum(NumOfImm) Desc

-- Top 10 country which has the highest immigrants to Canada
Select top 10 OdName, sum(NumOfImm) TotalOfImmigrants from canadav2
group by OdName
order by sum(NumOfImm) Desc
