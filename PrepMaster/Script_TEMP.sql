select * from fullmaster f ;

select column_name from fullmaster f ;

SELECT INFORMATION_SCHEMA.COLUMNS from public.fullmaster ;

SELECT column_name
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'sm_alldata_csv'
     ;
-- alter table public.fullmaster rename "       value" to "value";
    
    
 -- Select all column names in sm tables

SELECT table_name, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE table_name LIKE 'sm_%' AND (data_type='text' OR data_type='character varying');
    
 -- Trim all values in all columns in sm tables    

DO $$
DECLARE
    selectrow record;
BEGIN
FOR selectrow IN
    SELECT 
       'UPDATE '||quote_ident(c.table_name)||' 
		SET '||c.COLUMN_NAME||' = TRIM('||quote_ident(c.COLUMN_NAME)||') 
		WHERE '||quote_ident(c.COLUMN_NAME)||' LIKE ''% '' OR ' ||quote_ident(c.COLUMN_NAME)||' LIKE '' %''' AS script
	FROM (
        SELECT 
           table_name,COLUMN_NAME
        FROM 
           INFORMATION_SCHEMA.COLUMNS 
        WHERE 
           table_name LIKE 'sm_%' and (data_type='text' or data_type='character varying')
     ) c
loop
execute selectrow.script;
end loop;
end;
$$;

 -- SELECT TRIM("       value") FROM sm_alldata_csv sac;
 -- SELECT "       value" FROM sm_alldata_csv sac ;

 -- UPDATE sm_alldata_csv SET series_id = TRIM(series_id) WHERE series_id LIKE '% ' OR series_id LIKE ' %';

 -- SELECT * FROM sm_alldata_csv sac WHERE series_id LIKE 'SM%';