"""Simple Kafka Consumer"""
import os
import sys
from kafka import KafkaConsumer
from termcolor import colored


def process(consumer):
    while True:
        try:
            for message in consumer:
                print(f'--- {message.topic} - '
                      f'partition({message.partition})  '
                      f'offset({message.offset}) ---'
                      )
                print(colored(f'{message.key}', 'red'), end="")
                print(':', end="")
                print(colored(f'{message.value}', 'green'))
        except KeyboardInterrupt:
            print(colored('Shutting Down', 'green'))
            return


def main():
    topic = os.environ.get('APP_WEATHER_TOPIC', 'kubertron.weather.inbound')
    kafka_consumer = KafkaConsumer(topic,
                                   group_id='met-consumer-group-1',
                                   auto_offset_reset='earliest',
                                   bootstrap_servers=['localhost:29092'])
    process(kafka_consumer)
    return 0


if __name__ == '__main__':
    sys.exit(main())
