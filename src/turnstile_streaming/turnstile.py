'''Defines Turnstile data class'''
from dataclasses import dataclass


@dataclass
class Turnstile:
    """
    The Turnstile data class is the format of a message sent by a subway turnstile
    Attributes: 
        station_id      (int): UID for subway stations
        turnstile_id    (int): UID for turnstile within a subway station. (station_id, turnstile_id)
                               is a composite UID for a turnstile
        consumer_id     (int): UID for a registered consumer (subway rider)
        timestamp       (datetime): Time of event
    """
    station_id: int
    turnstile_id: int
