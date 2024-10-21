'''Defines dataclasses that store information from MTA Datasets'''
from dataclasses import dataclass, field

# The timestamp with which all timestamp-bound tables are filtered to
GLOBAL_TIMESTAMP_START = "'2023-01-02T00:00:00'"
GLOBAL_TIMESTAMP_END = "'2023-01-04T00:00:00'"


@dataclass
class MTADataset:
    """
    Class definition for datasets part of MTA Open Data Program. 
    """
    code: str                   # The dataset code passed to the Socrata API
    table_name: str             # The database object name
    default_where_clause: str   # How the table is filtered by default
    # The schema under which the table will be located in your database
    schema: str = "mta"

    # Overwritten after initialiation. Full database identifier for DuckDB
    identifier: str = ''

    def __post_init__(self):
        self.identifier = f"{self.schema}.{self.table_name}"


@dataclass
class Stations(MTADataset):
    """
    Subway Stations table is used in this project. 

    URL: https://data.ny.gov/Transportation/MTA-Subway-Stations/39hk-dx4f/about_data
    """
    code = "39hk-dx4f"
    table_name = "stations"
    default_where_clause = None

    def __init__(self):
        super().__init__(self.code, self.table_name, self.default_where_clause)


@dataclass
class HourlyRidership(MTADataset):
    """
    Hourly Ridership is used in this project. 

    URL: https://data.ny.gov/Transportation/MTA-Subway-Hourly-Ridership-Beginning-February-202/wujg-7c2s/about_data
    """
    code: str = field(default="wujg-7c2s")
    table_name: str = field(default="hourly_ridership")
    default_where_clause: str = field(default=f"transit_timestamp between {
        GLOBAL_TIMESTAMP_START} and {GLOBAL_TIMESTAMP_END}")

    def __init__(self, code=None, table_name=None, default_where_clause=None):
        # Allow overwriting the attributes if passed during initialization
        if code:
            self.code = code
        if table_name:
            self.table_name = table_name
        if default_where_clause:
            self.default_where_clause = default_where_clause

        super().__init__(self.code, self.table_name, self.default_where_clause)


@dataclass
class OriginDestination(MTADataset):
    """
    Origin Destination is used in this project 

    https://data.ny.gov/Transportation/MTA-Subway-Origin-Destination-Ridership-Estimate-2/uhf3-t34z/about_data
    """
    code: str = field(default="uhf3-t34z")
    table_name: str = field(default="origin_destination")
    default_where_clause: str = field(default=f"timestamp between {
        GLOBAL_TIMESTAMP_START} and {GLOBAL_TIMESTAMP_END}")

    def __init__(self, code=None, table_name=None, default_where_clause=None):
        # Allow overwriting the attributes if passed during initialization
        if code:
            self.code = code
        if table_name:
            self.table_name = table_name
        if default_where_clause:
            self.default_where_clause = default_where_clause

        super().__init__(self.code, self.table_name, self.default_where_clause)
