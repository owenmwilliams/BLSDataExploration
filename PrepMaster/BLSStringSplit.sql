drop table if exists public.masterdata_join;
drop table if exists tempdata;
drop table if exists tempdata2;

select * from PUBLIC.sm_alldata_csv sac ;

SELECT 
series_id,
TRIM(SUBSTRING(series_id, 1, 2)) AS prefix, 
TRIM(SUBSTRING(series_id, 3, 1)) AS seasonalcode,
TRIM(SUBSTRING(series_id, 4, 2)) AS statecode,
TRIM(SUBSTRING(series_id, 6, 5)) AS areacode,
TRIM(SUBSTRING(series_id, 11, 2)) AS sectorcode,
TRIM(SUBSTRING(series_id, 11, 8)) AS industrycode,
TRIM(SUBSTRING(series_id, 19, 2)) AS datacode
INTO tempdata
FROM public.sm_alldata_csv;

select * from tempdata;

select distinct series_id, prefix, seasonalcode, statecode, areacode, sectorcode, industrycode, datacode
into tempdata2
from tempdata;

alter table tempdata2 rename column series_id to id_code;

select *
into public.masterdata_join
from public.sm_alldata_csv sac
inner join tempdata2
on (sac.series_id = tempdata2.id_code)
ORDER BY sac.series_id;

alter table public.masterdata_join
drop column id_code;

select * from public.masterdata_join;

drop table tempdata;
drop table tempdata2;
