'''Module to setup duckdb database with no transformations from raw MTA data'''
import duckdb
import pandas as pd
from sodapy import Socrata
import config


# TODO: Allow multiple restrictions to be passed if the API allows


def extract_dataset(dataset_code: str,
                    restriction_type: str = None,
                    restriction: str = None,
                    limit: int = None
                    ) -> pd.DataFrame:
    """
    Extract dataset via API connection to NY Open Data Program

    Parameters:
        dataset_code     - A dataset code from the NY Open Data Program
        restriction_type - API calls can be restricted. Column that you want to filter
        restriction      - The value that you want to filter to

    Returns: 
        pd.Dataframe - Results returned from the API call 
    """

    client = Socrata("data.ny.gov",
                     config.NY_OPEN_DATA_API_TOKEN,
                     username=config.NY_OPEN_DATA_USERNAME,
                     password=config.NY_OPEN_DATA_PASSWORD)

    if restriction_type:
        results = client.get(dataset_code,
                             where=f"{restriction_type} = {restriction}",
                             limit=limit)
    else:
        results = client.get(dataset_code, limit=limit)

    records_df = pd.DataFrame.from_records(results)

    return records_df


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


def create_schema(db_conn: duckdb.DuckDBPyConnection,
                  schema_name: str
                  ) -> None:
    """
    Create schema in database if not exists

    Params: 
        conn - Connection to local DuckDB database. Typically returned by get_database_connection()
        schema_name - Schema name as string
    """

    db_conn.sql(f"CREATE SCHEMA IF NOT EXISTS {schema_name}")


if __name__ == "__main__":

    with get_database_connection(config.DEV_DATABASE) as conn:

        create_schema(conn, config.MTA_SCHEMA)

        # Build origin destination table restricted to a single day
        timestamp = "'2023-01-02T00:00:00'"
        origin_destination_df = extract_dataset(config.MTA_CODE_ORIGIN_DESTINATION_2023,
                                                restriction_type="timestamp",
                                                restriction=timestamp,
                                                limit=1000000)
        create_table(conn, origin_destination_df,
                     f"origin_destination_20230102")

        # Build stations table
        stations_df = extract_dataset(config.MTA_CODE_STATIONS,
                                      limit=10000000)
        create_table(conn, stations_df, f"stations")

        # Build reduced fare table
        reduced_fare_df = extract_dataset(config.MTA_CODE_REDUCED_FARE,
                                          limit=10000000)
        create_table(conn, reduced_fare_df, f"reduced_fare")