DROP TABLE IF EXISTS tempdata;

SELECT 
series_id,
TRIM(SUBSTRING(series_id, 1, 2)) AS prefix, 
TRIM(SUBSTRING(series_id, 3, 1)) AS seasonalcode,
TRIM(SUBSTRING(series_id, 4, 2)) AS statecode,
TRIM(SUBSTRING(series_id, 6, 5)) AS areacode,
TRIM(SUBSTRING(series_id, 11, 2)) AS sectorcode,
TRIM(SUBSTRING(series_id, 11, 8)) AS industrycode,
TRIM(SUBSTRING(series_id, 19, 2)) AS datacode
INTO public.tempdata
FROM public.sm_alldata_csv;

SELECT * FROM public.tempdata;

SELECT * FROM sm_state_code_csv sscc ;

SELECT * FROM sm_alldata_csv sac ;

SELECT SUBSTRING(sac.series_id, 4, 2), "year", "       value", sscc.state_name, sdtcc.data_type_text 
FROM sm_alldata_csv sac 
JOIN sm_state_code_csv sscc ON SUBSTRING(sac.series_id, 4, 2) = sscc."﻿state_code" 
JOIN sm_data_type_code_csv sdtcc ON SUBSTRING(sac.series_id, 19, 2) = sdtcc."﻿data_type_code" 
WHERE SUBSTRING(sac.series_id, 4, 2) = '31' AND YEAR > '1995';
