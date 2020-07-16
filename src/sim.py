"""Simulated Weather Data."""
import datetime
import json
import random


LOCATIONS = ['Hitchin Weather Station',
             'Ashwell',
             'FBP Langford',
             'Grosvenor Court',
             'St. Martins, Isles of Scilly',
             'Boswedden House']


class Sample:
    """Simulated weather station sample."""
    def __init__(self, location):
        temp_celsius = random.randint(18, 21)
        wind_speed = random.randint(5, 15)
        wind_direction = random.sample(
            ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'],
            1
        )
        humidity = random.randint(60, 70)
        pressure = random.randint(1010, 1020)
        self.location = location
        self.timestamp = datetime.datetime.now().isoformat()
        self.data = {
            'location': location,
            'temp_celsius': temp_celsius,
            'wind_speed_mph': wind_speed,
            'wind_direction': wind_direction,
            'humidity_percent': humidity,
            'pressure_mb': pressure
        }

    @property
    def json(self):
        """Get data as json.

        :returns (str): json str representation.
        """
        return json.dumps(self.data)


def make_sample():
    return Sample(random.sample(LOCATIONS, 1)[0])
