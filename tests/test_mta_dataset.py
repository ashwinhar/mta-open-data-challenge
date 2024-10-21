import database_setup.mta_dataset as mta


def test_stations_constructor():
    """
    Tests default construction for instances of mta.Stations
    """
    stations = mta.Stations()
    assert stations.code == "39hk-dx4f" and stations.table_name == 'stations' and stations.default_where_clause == None and stations.identifier == 'mta.stations'


def test_hourly_ridership_default():
    """
    Tests default construction for instances of mta.HourlyRidership
    """
    hr = mta.HourlyRidership()

    assert hr.code == "wujg-7c2s" and hr.table_name == "hourly_ridership" and hr.default_where_clause == f"transit_timestamp between {
        mta.GLOBAL_TIMESTAMP_START} and {mta.GLOBAL_TIMESTAMP_END}"


def test_hourly_ridership_custom():
    hr = mta.HourlyRidership(
        code='code', table_name='table_name', default_where_clause='dwc')

    assert hr.code == 'code' and hr.table_name == 'table_name' and hr.default_where_clause == 'dwc'
