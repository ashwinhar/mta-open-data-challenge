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





{% docs hourly_ridership %}

Staged data from the [MTA Subway Hourly Ridership](https://data.ny.gov/Transportation/MTA-Subway-Hourly-Ridership-Beginning-February-202/wujg-7c2s/about_data) dataset. This tabled is filtered by `transit_timestamp` and is set to be filtered to the `GLOBAL_TIMESTAMP`
variable in `*/fellowship_capstone/database_setup/mta_dataset.py`.

*Documentation copied directly from the MTA website*

{% enddocs %}


{% docs transit_timestamp %}

Timestamp payment took place in local time. All transactions here are rounded down to the nearest hour. For example, a swipe that took place at 1:37pm will be reported as having taken place at 1pm.

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs transit_mode %}

Distinguishes between the subway, Staten Island Railway, and the Roosevelt Island Tram

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs station_complex_id %}

A unique identifier for station complexes

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs station_complex %}

The subway complex where an entry swipe or tap took place. Large subway complexes, such as Times Square and Fulton Center, may contain multiple subway lines. The subway complex name includes the routes that stop at the complex in parenthesis, such as Zerega Av (6).

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs payment_method %}

Specifies whether the payment method used to enter was from OMNY or MetroCard.

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs fare_class_category %}

The class of fare payment used for the trip. The consolidated categories are:
- MetroCard (Fair Fare)
- MetroCard (Full Fare)
- MetroCard (Other)
- MetroCard (Senior & Disability)
- MetroCard (Students)
- MetroCard (Unlimited 30-Day)
- MetroCard (Unlimited 7-Day)
- OMNY (Full Fare)
- OMNY (Other)
- OMNY (Seniors & Disabilities)

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs ridership %}

Total number of riders that entered a subway complex via OMNY or MetroCard at the specific hour and for that specific fare type.

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}


{% docs transfers %}

Number of individuals who entered a subway complex via a free bus-to-subway, or free out-of-network transfer. This represents a subset of total ridership, meaning that these transfers are already included in the preceding ridership column. Transfers that take place within a subway complex (e.g., individuals transferring from the 2 to the 4 train within Atlantic Avenue) are not captured here.

*Documentation reformatted from MTA Data Dictionary*

{% enddocs %}

