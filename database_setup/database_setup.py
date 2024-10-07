'''Module to setup duckdb database with no transformations from raw MTA data'''
import duckdb
import pandas as pd
from sodapy import Socrata
import config
import mta_dataset as mta


# TODO: Allow multiple restrictions to be passed if the API allows


def extract_dataset(dataset_code: str,
                    where_clause: str = None
                    ) -> pd.DataFrame:
    """
    Extract dataset via API connection to NY Open Data Program

    Parameters:
        dataset_code     - A dataset code from the NY Open Data Program
        where_clause     - API calls can be restricted. Defines the filter. 

    Returns: 
        pd.Dataframe - Results returned from the API call 
    """

    limit = 100000000  # Limit records on API call

    client = Socrata("data.ny.gov",
                     config.NY_OPEN_DATA_API_TOKEN,
                     username=config.NY_OPEN_DATA_USERNAME,
                     password=config.NY_OPEN_DATA_PASSWORD)

    if where_clause:
        results = client.get(dataset_code,
                             where=where_clause,
                             limit=limit)
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


def create_table(db_conn: duckdb.DuckDBPyConnection,
                 results_dataframe: pd.DataFrame,
                 table_name: str
                 ) -> None:
    """
    Create table in local duckdb file

    Params: 
        conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        results_dataframe - Dataframe to create. Typically returned by extract_dataset()

    """
    # TODO: Create support for full refresh
    statement = f"CREATE TABLE IF NOT EXISTS {
        table_name} AS SELECT * FROM results_dataframe"
    db_conn.sql(statement)


def drop_table(db_conn: duckdb.DuckDBPyConnection,
               identifier: str
               ) -> None:
    """
    Drop table in local duckdb file

    Params: 
        conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        identifier - Database object to drop

    """
    # TODO: Create support for full refresh
    statement = f"DROP TABLE IF EXISTS {identifier}"
    db_conn.sql(statement)


def create_schema(db_conn: duckdb.DuckDBPyConnection,
                  schema_name: str
                  ) -> None:
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


def new_create_table(conn, mta_dataset: mta.MTADataset, overwrite=False):
    table_exists_flag = table_exists(
        conn, mta_dataset.schema, mta_dataset.table_name)

    if not table_exists_flag or overwrite:
        try:
            print(f"Starting extract for {mta_dataset.table_name}")
            df = extract_dataset(
                mta_dataset.code, mta_dataset.default_where_clause, )
            print(f"Extract successful")
            print("Creating table in database")
            drop_table(conn, mta_dataset.identifier)
            create_table(conn, df, mta_dataset.identifier)
        except Exception as e:
            print("Extract failed, exception message as follows")
            print(e)


def default_setup(overwrite=False) -> None:
    """
    Runs default setup based on each dataset instance in mta_dataset, as well as all manual_entry tables

    Params:
        overwrite (bool): If set to True, drops existing tables and creates new ones
    """

    with get_database_connection(config.DEV_DATABASE) as conn:

        # Create stations table
        stations = mta.Stations()
        new_create_table(conn, stations, overwrite)

        # Create hourly_ridershipt table
        hourly_ridership = mta.HourlyRidership()
        new_create_table(conn, hourly_ridership, overwrite)

        # Create origin_destination table
        origin_destination = mta.OriginDestination()
        new_create_table(conn, origin_destination, overwrite)


if __name__ == "__main__":

    default_setup()
