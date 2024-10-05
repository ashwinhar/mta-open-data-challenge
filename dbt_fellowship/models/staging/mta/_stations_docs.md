{% docs stations %}

Staged data from the [MTA Subway Stations dataset](https://data.ny.gov/Transportation/MTA-Subway-Stations/39hk-dx4f/about_data). 

A dataset listing all subway and Staten Island Railway stations, with information on their locations, Station Master Reference Number (MRN), Complex MRN, GTFS Stop ID, the services that stop there, the type of structure the station is on or in, whether the station is in Manhattan’s Central Business District (CBD), and their ADA-accessibility status.

*Documentation directly copied from MTA website*

{% enddocs %}


{% docs gtfs_stop_id %}

The ID used for the station in the General Transit Feed Specification (GTFS), an open standard used to display public transit schedule data.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs station_id %}

The Station Master Reference Number.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs complex_id %}

The Complex Master Reference Number.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs line %}

The operational line of the subway system the station is located on, such as Queens Blvd, Lexington Av, or Sea Beach.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs stop_name %}

The name of the subway station.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs borough %}

The borough the station is in.

| code | borough       |
|------|---------------|
| Bx   | Bronx         |
| B    | Brooklyn      |
| M    | Manhattan     |
| Q    | Queens        |
| SI   | Staten Island |

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs gtfs_latitude %}

The latitude for the centroid of the station.

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs gtfs_longitude %}

The longitude for the centroid of the station

*Documentation directly copied from MTA Data Dictionary*

{% enddocs %}


{% docs ada %}

| code | description                        |
|------|------------------------------------|
| 0    | The station is not ADA-accessible  |
| 1    | The station is fully accessible    |
| 2    | The station is partially accessible|

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs ada_northbound %}

| code | description                                                    |
|------|----------------------------------------------------------------|
| 0    | The station is not ADA-accessible in the northbound direction  |
| 1    | The station is fully accessible in the northbound direction    |
| 2    | The station is partially accessible in the northbound direction|

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs ada_southbound %}

| code | description                                                    |
|------|----------------------------------------------------------------|
| 0    | The station is not ADA-accessible in the southbound direction  |
| 1    | The station is fully accessible in the southbound direction    |
| 2    | The station is partially accessible in the southbound direction|

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}