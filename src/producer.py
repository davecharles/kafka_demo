"""Simple Kafka Producer"""
import os
import sys
import time

from kafka import KafkaProducer
from termcolor import colored

from . import sim


def main():
    """Main weather sample processing loop."""
    topic = os.environ.get('APP_WEATHER_TOPIC', 'kubertron.weather.inbound')
    producer = KafkaProducer(bootstrap_servers='localhost:29092')
    print(colored(f'Generating weather data', 'green'))
    while True:
        s = sim.make_sample()
        try:
            future = producer.send(topic,
                                   key=s.timestamp.encode('utf-8'),
                                   #key=b'1234',
                                   value=s.json.encode('utf-8'))
            record_metadata = future.get(timeout=10)
            print(f'--- {record_metadata.topic} - '
                  f'partition({record_metadata.partition})  '
                  f'offset({record_metadata.offset}) ---'
                  )
            time.sleep(1.0)
        except KeyboardInterrupt:
            print(colored('Shutting Down', 'green'))
            return 0


if __name__ == '__main__':
    sys.exit(main())
