'''Defines dataclasses that store information from MTA Datasets'''
from dataclasses import dataclass

# The timestamp with which all
GLOBAL_TIMESTAMP = "'2023-01-02T00:00:00'"


@dataclass
class MTADataset:
    code: str               # The dataset code passed to the Socrata API
    table_name: str         # The database object name
    timestamp: str          # Timestamp in string format for filtering, must be enclosed in double *and* single quotes. For example: "'2023-01-02T00:00:00'"
    schema: str = "mta"     # The schema under which the table will be located in your database

    # Overwritten after initialiation. Full database identifier for DuckDB
    identifier: str = ''

    def __post_init__(self):
        self.identifier = f"{self.schema}.{self.table_name}"


@dataclass
class Stations(MTADataset):
    code = "39hk-dx4f"
    table_name = "stations"
    timestamp = None

    def __init__(self):
        super().__init__(self.code, self.table_name, self.timestamp)


@dataclass
class HourlyRidership(MTADataset):
    code = "wujg-7c2s"
    table_name = "hourly_ridership"
    timestamp = GLOBAL_TIMESTAMP

    def __init__(self):
        super().__init__(self.code, self.table_name, self.timestamp)


@dataclass
class OriginDestination(MTADataset):
    code = "uhf3-t34z"
    table_name = "origin_destination"
    timestamp = GLOBAL_TIMESTAMP

    def __init__(self):
        super().__init__(self.code, self.table_name, self.timestamp)
