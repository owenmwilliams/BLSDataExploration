select * from masterdata_join;

select * from testtable;
drop table testtable;

select count(*) from fullmaster;

drop table if exists tempmastera;
drop table if exists tempmasterb;
drop table if exists temptable;

 -- column type lookup
-- SELECT column_name, data_type, udt_name::regtype
-- FROM information_schema.columns 
-- WHERE table_schema = 'public'
--   AND table_name = 'masterdata_join';

 -- generate random test table
-- select *
-- into temptable
-- from masterdata_join
-- order by random()
-- limit 1000;
-- select * from temptable;

 -- STATE CODE JOIN
select * from state_code;

 -- format lookup table to match masterdata (temptable)
select LPAD(state_code::text, 2, '0'), state_name into state_code2 from state_code;
select * from state_code2;

 -- join new master table on lookup
select *
into tempmasterA
from masterdata_join
inner join state_code2
on (masterdata_join.statecode = state_code2.lpad)
ORDER BY masterdata_join.series_id;

 -- drop temporary tables and columns
drop table state_code2;
alter table tempmasterA drop column lpad;
select * from tempmasterA;


 -- AREA CODE JOIN
select * from area_code;

 -- format lookup table to match masterdata (temptable)
select LPAD(area_code::text, 5, '0'), area_name into area_code2 from area_code;
select * from area_code2;

 -- join new master table on lookup
select *
into tempmasterB
from tempmasterA
inner join area_code2
on (tempmasterA.areacode = area_code2.lpad)
ORDER BY tempmasterA.series_id;

 -- drop temporary tables and columns
drop table area_code2;
drop table tempmasterA;
alter table tempmasterB drop column lpad;
select * from tempmasterB;


 -- SECTOR CODE JOIN
select * from sector_code;

 -- format lookup table to match masterdata (temptable)
select LPAD(supersector_code::text, 2, '0'), supersector_name into sector_code2 from sector_code;
select * from sector_code2;

 -- join new master table on lookup
select *
into tempmasterA
from tempmasterB
inner join sector_code2
on (tempmasterB.sectorcode = sector_code2.lpad)
ORDER BY tempmasterB.series_id;

 -- drop temporary tables and columns
drop table sector_code2;
drop table tempmasterB;
alter table tempmasterA drop column lpad;
select * from tempmasterA;


 -- INDUSTRY CODE JOIN
select * from industry_code;

 -- format lookup table to match masterdata (temptable)
select LPAD(industry_code::text, 8, '0'), industry_name into industry_code2 from industry_code;
select * from industry_code2;

 -- join new master table on lookup
select *
into tempmasterB
from tempmasterA
inner join industry_code2
on (tempmasterA.industrycode = industry_code2.lpad)
ORDER BY tempmasterA.series_id;

 -- drop temporary tables and columns
drop table industry_code2;
drop table tempmasterA;
alter table tempmasterB drop column lpad;
select * from tempmasterB;

 -- DATA CODE JOIN
select * from data_code;

 -- format lookup table to match masterdata (temptable)
select LPAD(data_type_code::text, 2, '0'), data_type_text into data_code2 from data_code;
select * from data_code2;

 -- join new master table on lookup
select *
into fullmaster
from tempmasterB
inner join data_code2
on (tempmasterB.datacode = data_code2.lpad)
ORDER BY tempmasterB.series_id;

 -- drop temporary tables and columns
drop table data_code2;
drop table tempmasterB;
alter table fullmaster drop column lpad;
select * from fullmaster;