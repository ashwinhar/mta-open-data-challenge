"""Module to setup duckdb database with no transformations from raw MTA data"""

import duckdb
import pandas as pd
from sodapy import Socrata
import database_setup.mta_dataset as mta
from dotenv import load_dotenv
import os
import time

load_dotenv()

# Open Data Constsants
NY_OPEN_DATA_API_TOKEN = os.getenv("NY_OPEN_DATA_API_TOKEN")
NY_OPEN_DATA_USERNAME = os.getenv("NY_OPEN_DATA_USERNAME")
NY_OPEN_DATA_PASSWORD = os.getenv("NY_OPEN_DATA_PASSWORD")

# Database Constants
MTA_SCHEMA = os.getenv("MTA_SCHEMA")
DEV_DATABASE = os.getenv("DEV_DATABASE")
MANUAL_ENTRY_SCHEMA = os.getenv("MANUAL_ENTRY_SCHEMA")

# File paths
NEAREST_ADA_STATIONS_PATH = "data/nearest_ada_stations.csv"
TRAVEL_TIMES_PATH = "data/travel_times.csv"
#############################################################################################


def extract_dataset(dataset_code: str, where_clause: str = None) -> pd.DataFrame:
    """
    Extract dataset via API connection to NY Open Data Program

    Parameters:
        dataset_code     - A dataset code from the NY Open Data Program. Examples can be found in mta_dataset.py
        where_clause     - API calls can be restricted. Defines the filter.

    Returns:
        pd.Dataframe - Results returned from the API call
    """

    limit = 100000000  # Limit records on API call

    client = Socrata(
        "data.ny.gov",
        NY_OPEN_DATA_API_TOKEN,
        username=NY_OPEN_DATA_USERNAME,
        password=NY_OPEN_DATA_PASSWORD,
    )

    if where_clause:
        results = client.get(dataset_code, where=where_clause, limit=limit)
    else:
        results = client.get(dataset_code, limit=limit)

    return pd.DataFrame.from_records(results)


def get_database_connection(database_path: str) -> duckdb.DuckDBPyConnection:
    """
    Return connection to local DuckDB database

    Params:
        database_path - Absolute path
    Returns:
        DuckDBPyConnection
    """
    return duckdb.connect(database_path)


def create_table(
    db_conn: duckdb.DuckDBPyConnection, results_dataframe: pd.DataFrame, table_name: str
) -> None:
    """
    Create table in local DuckDB database

    Params:
        db_conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        results_dataframe - Dataframe to create. Typically returned by extract_dataset()
        table_name - Full database object identifier

    """
    statement = f"CREATE TABLE {
        table_name} AS SELECT * FROM results_dataframe"
    db_conn.sql(statement)


def drop_table(db_conn: duckdb.DuckDBPyConnection, identifier: str) -> None:
    """
    Drop table if exists in local duckdb file

    Params:
        db_conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        identifier - Database object to drop

    """
    statement = f"DROP TABLE IF EXISTS {identifier}"
    db_conn.sql(statement)


def create_schema(db_conn: duckdb.DuckDBPyConnection, schema_name: str) -> None:
    """
    Create schema in database if not exists

    Params:
        db_conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        schema_name - Schema name as string
    """

    db_conn.sql(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")


def table_exists(db_conn: duckdb.DuckDBPyConnection, schema_name, table_name) -> bool:
    """
    Checks if table exists in DuckDB database.

    Params:
        db_conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        schema_name - Schema name as string
        table_name - Table name as string
    Returns:
        bool - True if table exists, False if it doesn't
    """

    query = f"""
    SELECT 1
    FROM information_schema.tables
    WHERE
            table_schema = '{schema_name}'
        AND table_name = '{table_name}'
    """
    result = db_conn.sql(query).fetchone()
    return result is not None


def new_create_table(
    conn: duckdb.DuckDBPyConnection, mta_dataset: mta.MTADataset, overwrite=False
) -> None:
    """
    Full EL process from NY Open Dataset to local database

    Params:
        conn: Connection to local DuckDB database. Typically returned by get_database_connection()
        mta_dataset: Instance of MTADataset dataclass. Dataset to extract from NY Open Data Program
        overwrite (bool): If True, then database object at mta_dataset.identifier is dropped and created fresh

    """
    table_exists_flag = table_exists(conn, mta_dataset.schema, mta_dataset.table_name)

    if not table_exists_flag or overwrite:
        try:
            print(f"Starting extract for {mta_dataset.table_name}")
            df = extract_dataset(
                mta_dataset.code,
                mta_dataset.default_where_clause,
            )
            print("Extract successful")
            print("Creating table in database")
            drop_table(conn, mta_dataset.identifier)
            create_table(conn, df, mta_dataset.identifier)
        except Exception as e:
            print("Extract failed, exception message as follows")
            print(e)


def year_setup(overwrite=False) -> None:
    """
    Set up full year of data (2023) for OriginDestination and HourlyRidership

    Be very careful with this! This takes several hours to complete, but is necessary for the current state of the model.
    time.sleep(x) is used because I noticed that the API sometimes times out for large requests.

    Params:
        overwrite (bool) - Whether to drop existing tables (if exists) and create a new one.
    """
    od_template = mta.OriginDestination()
    hr_template = mta.HourlyRidership()
    default_name_od = od_template.table_name
    default_name_hr = hr_template.table_name

    timestamp_dict = {
        1: {"start": "'2023-01-01T00:00:00'", "end": "'2023-02-01T00:00:00'"},
        2: {"start": "'2023-02-01T00:00:00'", "end": "'2023-03-01T00:00:00'"},
        3: {"start": "'2023-03-01T00:00:00'", "end": "'2023-04-01T00:00:00'"},
        4: {"start": "'2023-04-01T00:00:00'", "end": "'2023-05-01T00:00:00'"},
        5: {"start": "'2023-05-01T00:00:00'", "end": "'2023-06-01T00:00:00'"},
        6: {"start": "'2023-06-01T00:00:00'", "end": "'2023-07-01T00:00:00'"},
        7: {"start": "'2023-07-01T00:00:00'", "end": "'2023-08-01T00:00:00'"},
        8: {"start": "'2023-08-01T00:00:00'", "end": "'2023-09-01T00:00:00'"},
        9: {"start": "'2023-09-01T00:00:00'", "end": "'2023-10-01T00:00:00'"},
        10: {"start": "'2023-10-01T00:00:00'", "end": "'2023-11-01T00:00:00'"},
        11: {"start": "'2023-11-01T00:00:00'", "end": "'2023-12-01T00:00:00'"},
        12: {"start": "'2023-12-01T00:00:00'", "end": "'2024-01-01T00:00:00'"},
    }

    with get_database_connection(DEV_DATABASE) as conn:
        for month in range(1, 13):
            print(f"Building tables for month={month}")
            where_clause = f"month = {month} AND year = 2023"
            od_monthly = mta.OriginDestination(
                table_name=default_name_od + f"_{month}",
                default_where_clause=where_clause,
            )
            new_create_table(conn, od_monthly, overwrite)
            time.sleep(10)

            hr_where_clause = f"transit_timestamp >= {timestamp_dict[month].get('start')} and transit_timestamp < {
                timestamp_dict[month].get('end')}"

            hr_monthly = mta.HourlyRidership(
                table_name=default_name_hr + f"_{month}",
                default_where_clause=hr_where_clause,
            )
            new_create_table(conn, hr_monthly, overwrite)
            time.sleep(30)


def default_setup(overwrite=False) -> None:
    """
    Runs default setup based on each dataset instance in mta_dataset, as well as all manual_entry tables

    Params:
        overwrite (bool): If set to True, drops existing tables and creates new ones
    """

    with get_database_connection(DEV_DATABASE) as conn:

        # Create necessary schemas if not exists
        create_schema(conn, MANUAL_ENTRY_SCHEMA)
        create_schema(conn, MTA_SCHEMA)

        # Create stations table
        stations = mta.Stations()
        new_create_table(conn, stations, overwrite)

        # Create hourly_ridership table
        hourly_ridership = mta.HourlyRidership()
        new_create_table(conn, hourly_ridership, overwrite)

        # Create origin_destination table
        origin_destination = mta.OriginDestination()
        new_create_table(conn, origin_destination, overwrite)

        # Create manual entry nearest_ada_stations table. Manual entry tables have a different flow.
        # Note that nearest_ada_stations was built by hand, not via API request
        nearest_ada_stations_df = pd.read_csv(NEAREST_ADA_STATIONS_PATH)
        if (
            not table_exists(conn, MANUAL_ENTRY_SCHEMA, "nearest_ada_stations")
            or overwrite
        ):
            create_table(
                conn,
                nearest_ada_stations_df,
                f"{MANUAL_ENTRY_SCHEMA}.nearest_ada_stations",
            )

        # Create manual entry travel_times table
        travel_times_df = pd.read_csv(TRAVEL_TIMES_PATH)
        if not table_exists(conn, MANUAL_ENTRY_SCHEMA, "travel_times") or overwrite:
            create_table(
                conn,
                travel_times_df,
                f"{MANUAL_ENTRY_SCHEMA}.travel_times",
            )


if __name__ == "__main__":

    default_setup()
