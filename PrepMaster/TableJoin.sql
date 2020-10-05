drop table if exists testtable;
drop table if exists tempmastera;
drop table if exists tempmasterb;
drop table if exists temptable;
drop table if exists state_code2;
drop table if exists fullmaster;


 -- [STATE CODE JOIN] --

 -- format lookup table to match masterdata (temptable)
select LPAD(sscc."﻿state_code"::text, 2, '0'), state_name into state_code2 from sm_state_code_csv sscc ;
select * from state_code2;

 -- join new master table on lookup
select *
into tempmasterA
from public.masterdata_join mj
inner join state_code2
on (mj.statecode = state_code2.lpad)
ORDER BY mj.series_id;

 -- drop temporary tables and columns
drop table state_code2;
alter table tempmasterA drop column lpad;


 -- [AREA CODE JOIN] --

 -- format lookup table to match masterdata (temptable)
select LPAD(sacc."﻿area_code" ::text, 5, '0'), area_name into area_code2 from sm_area_code_csv sacc ;
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


 -- [SECTOR CODE JOIN] --

 -- format lookup table to match masterdata (temptable)
select LPAD(ssccc."﻿supersector_code" ::text, 2, '0'), supersector_name into sector_code2 from public.sm_supersector_code_csv ssccc ;
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


 -- [INDUSTRY CODE JOIN] --

 -- format lookup table to match masterdata (temptable)
select LPAD(sicc."﻿industry_code" ::text, 8, '0'), industry_name into industry_code2 from public.sm_industry_code_csv sicc;
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


 -- [DATA CODE JOIN] --

 -- format lookup table to match masterdata (temptable)
select LPAD(sdtcc."﻿data_type_code" ::text, 2, '0'), data_type_text into data_code2 from public.sm_data_type_code_csv sdtcc ;
select * from data_code2;

 -- join new master table on lookup
select *
into public.fullmaster
from tempmasterB
inner join data_code2
on (tempmasterB.datacode = data_code2.lpad)
ORDER BY tempmasterB.series_id;

 -- drop temporary tables and columns
drop table data_code2;
drop table tempmasterB;
alter table public.fullmaster drop column lpad;
select * from public.fullmaster;