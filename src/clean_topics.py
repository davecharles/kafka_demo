"""Delete topics"""
import sys

from kafka.admin import KafkaAdminClient
from kafka.errors import UnknownTopicOrPartitionError
from termcolor import colored


def del_topics(ac, topics):
    for topic in topics:
        try:
            ac.delete_topics([topic])
            print(colored(f'{topic} deleted', 'green'))
        except UnknownTopicOrPartitionError:
            print(colored(f'{topic} does not exist', 'red'))


def main():
    topics = sys.argv[1:]
    if not topics:
        print(colored('No topics specified', 'red'))
        return 128
    admin_client = KafkaAdminClient(bootstrap_servers=['localhost:29092'],
                                    client_id='destroyer')
    del_topics(admin_client, topics)
    return 0


if __name__ == '__main__':
    sys.exit(main())
