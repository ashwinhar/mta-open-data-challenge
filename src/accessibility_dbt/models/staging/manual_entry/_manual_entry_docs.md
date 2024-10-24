{% docs nearest_ada_stations %}

This table details the 30 stations that are eligible for ADA access improvements under the [2025-2029 Capital Plan] (https://future.mta.info/capitalplan/). The `planned_ada_station_name` is copied exactly from the Capital Plan, and is repeated in two separate cases (where multiple stations within a complex are part of the ADA expansion).

Then, I define my best guess for the two closest complexes (one in either direction of the station) that are at least partially ADA-accessible, and therefore where a disabled person would need to currently get off at to reach the `planned_ada_station`. In this case "partially ADA-accessible" means any complex that has at least one record in `mta.stations` with `ada = 1`. 

For example, imagine a straight line with stations A, B, C, D where someone wants to get on at A and exit at C. However, only A, B, and D are ADA-accessible. Station C might be a `planned_ada_station_name` and B and D would be the `northbound_nearest_complex_id` and `southbound_nearest_complex_id`. A disabled person would need to enter at station A, get off at either B or D, and then get back to C somehow (using their wheelchair, walking with support, etc).

{% enddocs %}


{% docs mta_sort_order %}

The order that the `planned_ada_station_name` appeared in the Capital Plan. It's unknown if this number is an indication of priority or if it's arbitrary.

{% enddocs %}


{% docs planned_ada_complex_id %}

The `complex_id` that the `station_id` belongs to in `mta.stations`. 

{% enddocs %}


{% docs planned_ada_station_id %}

My best guess as to the matching `station_id` available in `mta.stations`. 

{% enddocs %}


{% docs planned_ada_station_name %}

The exact station name referenced in pg. 187 (pdf pg. 95) of the [2025-2029 Capital Plan] (https://future.mta.info/capitalplan/) planned for ADA access. May be repeated across records in case the station name references multiple `station_id` values. 

{% enddocs %}


{% docs northbound_nearest_complex_id %}

The nearest at least partially accessible complex (at least one record in `mta.stations` with `ada = 1`) in the northbound direction. The "northbound" direction isn't super precise, and was just done looking at [this map](https://new.mta.info/node/5346).

{% enddocs %}


{% docs northbound_nearest_station_name %}

The station that the complex belongs to, again written by looking at [this map](https://new.mta.info/node/5346). It may not *precisely* match the official station name, but it should be close enough to understand which station the corresponding `complex_id` is referencing. Plus, using `mta.stations`, you can get the actual latitude and longitude of the station.

{% enddocs %}


{% docs southbound_nearest_complex_id %}

The nearest at least partially accessible complex (at least one record in `mta.stations` with `ada = 1`) in the southbound direction. The "southbound" direction isn't super precise, and was just done looking at [this map](https://new.mta.info/node/5346).

{% enddocs %}


{% docs southbound_nearest_station_name %}
The station that the complex belongs to, again written by looking at [this map](https://new.mta.info/node/5346). It may not *precisely* match the official station name, but it should be close enough to understand which station the corresponding `complex_id` is referencing. Plus, using `mta.stations`, you can get the actual latitude and longitude of the station.

{% enddocs %}


{% docs travel_times %}
This table contains travel time information between two locations, both walking and train travel time. The TravelTimeAPI was used to get these numbers. 

{% enddocs %}


{% docs complex_latitude %}
The latitude of a station part of the complex (pulled from `mta.stations`). The complex is assumed to be small enough such that any station's latitude is close enough to the complex centroid.

{% enddocs %}


{% docs complex_longitude %}
The longitude of a station part of the complex (pulled from `mta.stations`). The complex is assumed to be small enough such that any station's longitude is close enough to the complex centroid

{% enddocs %}


{% docs existing_ada_complex_id %}
One of the nearest at least partially accessible complex (at least one record in `mta.stations` with `ada = 1`) in either the southbound or northbound direction. Inferred from [this map](https://new.mta.info/node/5346).

{% enddocs %}


{% docs existing_ada_stop_name %}
Any stop in the complex. Should be close enough to understand what the `complex_id` is referencing. Plus, using `mta.stations`, you can get more information about all stops part of the `complex_id`.

{% enddocs %}


{% docs walking_time_sec %}
The walking time in seconds between the two locations, based on the [TravelTimeAPI](https://docs.traveltime.com/api/overview/introduction)

{% enddocs %}

{% docs train_time_sec %}
The train time in seconds between the two locations, based on the [TravelTimeAPI](https://docs.traveltime.com/api/overview/introduction)

{% enddocs %}