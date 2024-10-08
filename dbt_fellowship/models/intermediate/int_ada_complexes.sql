SELECT 
    complex_id						ada_complex_id
   ,list(DISTINCT stop_name)		stop_name_list
   ,list(line)						line_list
FROM {{ref("stg_stations")}}
WHERE ada = 1
GROUP BY complex_id