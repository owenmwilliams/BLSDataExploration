 -- Extremely convoluted way to remove UTF BOM from column names

SELECT * FROM sm_state_code_csv sscc2 ;
SELECT "﻿state_code" FROM sm_state_code_csv sscc ;
ALTER TABLE public.sm_state_code_csv RENAME COLUMN "﻿state_code" TO "state_code";
SELECT* FROM sm_state_code_csv sscc ;
SELECT state_code FROM sm_state_code_csv sscc ;
SELECT state_name FROM sm_state_code_csv sscc ;

SELECT * FROM sm_supersector_code_csv sscc ;
SELECT "﻿supersector_code" FROM sm_supersector_code_csv sscc ;
ALTER TABLE public.sm_supersector_code_csv RENAME COLUMN "﻿supersector_code" TO "supersector_code";
SELECT * FROM sm_supersector_code_csv sscc ;
SELECT supersector_code FROM sm_supersector_code_csv sscc ;
SELECT supersector_name FROM sm_supersector_code_csv sscc ;

SELECT * FROM sm_data_type_code_csv sdtcc ;
ALTER TABLE sm_alldata_csv DROP COLUMN footnote_codes;