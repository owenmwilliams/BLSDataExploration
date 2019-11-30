select * from alldata;

SELECT 
series_id,
SUBSTRING(series_id, 1, 2) AS prefix, 
SUBSTRING(series_id, 3, 1) AS seasonalcode,
SUBSTRING(series_id, 4, 2) AS statecode,
SUBSTRING(series_id, 6, 5) AS areacode,
SUBSTRING(series_id, 11, 2) AS sectorcode,
SUBSTRING(series_id, 11, 8) AS industrycode,
SUBSTRING(series_id, 19, 2) AS datacode
INTO tempdata
FROM alldata;

select distinct series_id, prefix, seasonalcode, statecode, areacode, sectorcode, industrycode, datacode
into tempdata2
from tempdata;

alter table tempdata2 rename column series_id to id_code;

select *
into masterdata_join
from alldata
inner join tempdata2
on (alldata.series_id = tempdata2.id_code)
ORDER BY alldata.series_id;

alter table masterdata_join
drop column id_code;

select * from masterdata_join;

drop table tempdata;
drop table tempdata2;
