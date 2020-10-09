 -- Substring locations of primary keys in lookup tables based on series_id --

---prefix == TRIM(SUBSTRING(series_id, 1, 2))
---seasonal_code == TRIM(SUBSTRING(series_id, 3, 1))
---state_code == TRIM(SUBSTRING(series_id, 4, 2))
---area_code == TRIM(SUBSTRING(series_id, 6, 5))
---sector_code == TRIM(SUBSTRING(series_id, 11, 2))
---industry_code == TRIM(SUBSTRING(series_id, 11, 8))
---data_type_code == TRIM(SUBSTRING(series_id, 19, 2))

 -- Specific query using a join and lookup tables
 
---SELECT "year", value , sscc.state_name, sdtcc.data_type_text 
---FROM sm_alldata_csv sac 
---JOIN sm_state_code_csv sscc ON substring(sac.series_id, 4, 2) = sscc.state_code 
---JOIN sm_data_type_code_csv sdtcc ON substring(sac.series_id, 19, 2) = sdtcc.data_type_code 
---WHERE substring(sac.series_id, 4, 2) = '31' AND substring(sac.series_id, 19, 2) = '11';

 -- Select distinct substrings for prefix & seasonal_code

SELECT DISTINCT trim(substring(series_id,1,2)) FROM sm_alldata_csv sac ;
SELECT DISTINCT trim(substring(series_id, 3, 1)) FROM sm_alldata_csv sac ;

 -- Confirming equal counts on join --
 
---SELECT DISTINCT(trim(substring(series_id, 4, 2))) FROM sm_alldata_csv sac ORDER BY btrim;
---SELECT DISTINCT(lpad(state_code ::text, 2, '0')) FROM sm_state_code_csv sscc ORDER BY lpad ;
---SELECT count(DISTINCT(sscc.state_name))
---	FROM sm_alldata_csv sac 
---	JOIN sm_state_code_csv sscc 
---	ON substring(sac.series_id, 4, 2) = lpad(sscc.state_code ::TEXT, 2, '0');

SELECT * FROM sm_area_code_csv sacc ;

 -- Select distinct substrings for remaining

SELECT DISTINCT substring(series_id, 4, 2), sscc.state_name 
	FROM sm_alldata_csv sac 
	JOIN sm_state_code_csv sscc 
	ON substring(sac.series_id, 4, 2) = lpad(sscc.state_code ::text, 2, '0')
	ORDER BY sscc.state_name ASC;

SELECT DISTINCT substring(series_id, 6, 5), sacc.area_name 
	FROM sm_alldata_csv sac
	JOIN sm_area_code_csv sacc 
	ON substring(series_id, 6, 5) = lpad(sacc.area_code ::TEXT, 5, '0')
	ORDER BY sacc.area_name ASC;

SELECT DISTINCT substring(series_id, 11, 2), sscc.supersector_name 
	FROM sm_alldata_csv sac 
	JOIN sm_supersector_code_csv sscc 
	ON substring(series_id, 11, 2) = lpad(sscc.supersector_code ::TEXT, 2, '0')
	ORDER BY sscc.supersector_name ASC;

SELECT DISTINCT substring(series_id, 11, 8), sicc.industry_name 
	FROM sm_alldata_csv sac 
	JOIN sm_industry_code_csv sicc 
	ON substring(series_id, 11, 8) = lpad(sicc.industry_code ::TEXT, 8, '0')
	ORDER BY sicc.industry_name ASC;

SELECT DISTINCT trim(substring(series_id, 19, 2)), sdtcc.data_type_text 
	FROM sm_alldata_csv sac 
	JOIN sm_data_type_code_csv sdtcc 
	ON substring(series_id, 19, 2) = lpad(sdtcc.data_type_code ::TEXT, 2, '0')
	ORDER BY sdtcc.data_type_text ASC;
	
 -- Specific query

SELECT * FROM sm_data_type_code_csv sdtcc2 ;

SELECT sicc.industry_name, sdtcc.data_type_text, "year", value
	FROM sm_alldata_csv sac 
	JOIN sm_industry_code_csv sicc 
		ON substring(series_id, 11, 8) = lpad(sicc.industry_code ::TEXT, 8, '0')
	JOIN sm_supersector_code_csv sscc
		ON substring(series_id, 11, 2) = lpad(sscc.supersector_code ::TEXT, 2, '0')
	JOIN sm_data_type_code_csv sdtcc 
		ON substring(series_id, 19, 2) = lpad(sdtcc.data_type_code ::TEXT, 2, '0')
	WHERE substring(series_id, 11, 2) = '60' 
		AND substring(series_id, 19, 2) = '11'
		AND sac."year" = '2011'
		AND sac."period" = 'M13'
		AND substring(series_id, 6, 5) = '00000'
		AND substring(series_id, 4, 2) = '06'
	ORDER BY sicc.industry_name ASC;