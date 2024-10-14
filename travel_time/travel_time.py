''' Module to use TravelTime API to get walking and public transit time'''

from traveltimepy import Location, Transportation, Walking, Coordinates, TravelTimeSdk, Property, FullRange, PublicTransport
# Full setup
import numpy as np
import pandas as pd
import asyncio
from datetime import datetime
from dataclasses import dataclass


@dataclass
class StationGeography:
    '''Simple way to store a station identifier (no tight definition around this) and a lat/long pair'''
    station_id: str     # Any identifier for the station
    latitude: float
    longitude: float


async def time_filter_wrapper(sdk: TravelTimeSdk, origin: StationGeography, destination: StationGeography, transport_type: Transportation) -> int:
    """
    Wrapper to get TravelTimeSdk to work with code. Largely copied from the API documentation.
    This is set as async in Python because the function in the API requires it.

    Parameters:
        sdk - Instance of TravelTimeSdk with app_id and api_key, which you can get for free
        origin - Instance of StationGeography, this is the origin of the trip
        destination - Instnace of StationGeography, this is the destination of the trip
        transport_type - Could pass any instance of Transportation.


    """
    locations = [
        Location(id=origin.station_id, coords=Coordinates(
            lat=origin.latitude, lng=origin.longitude)),
        Location(id=destination.station_id, coords=Coordinates(
            lat=destination.latitude, lng=destination.longitude))
    ]

    results = await sdk.time_filter_async(
        locations=locations,
        search_ids={
            origin.station_id: [destination.station_id]
        },
        departure_time=datetime.now(),
        # max travel time (sec) allowed by the API, ensures that it doesn't return NULL, even if there is a valid path
        travel_time=10800,
        # I pass either Walking or Transportation(public_transit = "train")
        transportation=transport_type,
        properties=[Property.TRAVEL_TIME],
        range=FullRange(enabled=False, max_results=3, width=600)
    )
    try:
        # The API is funky, so the extraction doesn't work sometimes
        travel_time = results[0].__dict__.get(
            'locations')[0].properties[0].travel_time
    except Exception as e:
        print(e)
        travel_time = None

    return travel_time


async def process_all_rows(sdk: TravelTimeSdk, df: pd.DataFrame, transport_type: Transportation):
    """
    New attempt at running all rows in a dataframe

    sdk: Instance of TravelTimeSdk
    df: Dataframe in the specific latlong format from the data model
    """
    if transport_type == Walking():
        col_name = 'walking_time_sec'
    else:
        col_name = 'train_time_sec'

    for index, row in df.iterrows():
        destination = StationGeography(row['planned_ada_station_name'],
                                       row['planned_ada_complex_latitude'],
                                       row['planned_ada_complex_longitude'])
        origin = StationGeography(row['existing_ada_stop_name'],
                                  row['existing_ada_complex_latitude'],
                                  row['existing_ada_complex_longitude'])
        print(f"Processing row {index}")
        print(origin)
        print(destination)
        if origin.latitude is not None and destination.latitude is not None:
            # Will not work if either side is None
            travel_time_sec = await time_filter_wrapper(sdk, origin, destination, transport_type)
            print(f"{col_name} set to {travel_time_sec} for index = {index}")
            df.at[index, col_name] = travel_time_sec
        else:
            df.at[index, col_name] = None

    return df

if __name__ == "__main__":
    df_latlongs = pd.read_csv(
        'travel_time/latlongs.csv').replace({np.nan: None})

    sdk = TravelTimeSdk(app_id="87ebd830",
                        api_key="a084a6856d76b7580d8390859bff3ac8")

    # Running the async loop
    new_df = asyncio.run(process_all_rows(sdk, df_latlongs, Walking()))
    full_df = asyncio.run(process_all_rows(
        sdk, df_latlongs, PublicTransport(type='train')))
    new_df.to_csv('results_async.csv')
