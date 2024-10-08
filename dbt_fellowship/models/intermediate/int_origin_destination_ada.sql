SELECT 
	*
FROM {{ref("stg_origin_destination")}}	                            sod
inner join	{{ref("int_ada_complexes")}}	                        iac_o
	on sod.origin_station_complex_id = iac_o.ada_complex_id
inner join {{ref("int_ada_complexes")}}		                        iac_d
	on sod.destination_station_complex_id = iac_d.ada_complex_id
