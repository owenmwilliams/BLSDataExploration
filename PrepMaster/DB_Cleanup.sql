 -- Select column names from a specific table

SELECT column_name
  FROM information_schema.columns
 WHERE table_schema = 'public'
   AND table_name   = 'sm_area_code_csv';
    
 -- Select all column names in sm tables

SELECT table_name, COLUMN_NAME
  FROM information_schema.columns
 WHERE table_name LIKE 'sm_%' 
   AND (data_type='text' OR data_type='character varying');
    
 -- Trim all values in all columns in sm tables    

      DO $$
 DECLARE selectrow record;
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
   LOOP
 EXECUTE selectrow.script;
END LOOP;
     END;
      $$;
