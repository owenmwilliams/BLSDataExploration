 -- select * from public.fullmaster;

 -- Remove blank columns

 -- ALTER TABLE public.fullmaster DROP COLUMN footnote_codes;

 -- Trim ALL VALUES

SELECT trim(value) FROM public.fullmaster f ;
SELECT value FROM public.fullmaster f ;
