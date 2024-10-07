'''Defines dataclasses that store information from MTA Datasets'''
from dataclasses import dataclass

# The timestamp with which all timestamp-bound tables are filtered to
GLOBAL_TIMESTAMP_START = "'2023-01-02T00:00:00'"
GLOBAL_TIMESTAMP_END = "'2023-01-04T00:00:00'"


@dataclass
class MTADataset:
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
    code = "39hk-dx4f"
    table_name = "stations"
    default_where_clause = None

    def __init__(self):
        super().__init__(self.code, self.table_name, self.default_where_clause)


@dataclass
class HourlyRidership(MTADataset):
    code = "wujg-7c2s"
    table_name = "hourly_ridership"
    default_where_clause = f"transit_timestamp between {
        GLOBAL_TIMESTAMP_START} and {GLOBAL_TIMESTAMP_END}"

    def __init__(self):
        super().__init__(self.code, self.table_name, self.default_where_clause)


@dataclass
class OriginDestination(MTADataset):
    code = "uhf3-t34z"
    table_name = "origin_destination"
    default_where_clause = f"timestamp between {
        GLOBAL_TIMESTAMP_START} and {GLOBAL_TIMESTAMP_END}"

    def __init__(self):
        super().__init__(self.code, self.table_name, self.default_where_clause)
