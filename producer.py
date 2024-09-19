'''Producer class. This will likely be a particular turnstile in the system'''
import json
from datetime import datetime
from confluent_kafka import Producer
from turnstile_event import TurnstileEvent
from turnstile import Turnstile


# File where plaintext port dumped from running start_kafka_instance.sh
KAFKA_PLAINTEXT_PORT_FILE = 'extracted_plaintext_port.txt'

# Topic of producer
PRODUCER_TOPIC = 'purchases'


def delivery_callback(err, msg):
    """
    Boilerplate code from Confluent. Optional per-message delivery callback (triggered by poll()
    or flush()) when a message has been successfully delivered or permanently failed delivery 
    (after retries).
    """
    if err:
        print('ERROR: Message failed delivery: {}'.format(err))
    else:
        print("Produced event to topic {topic}: key = {key:12} value = {value:12}".format(
            topic=msg.topic(), key=msg.key().decode('utf-8'), value=msg.value().decode('utf-8')))


def generate_dummy_event(turnstile_input: Turnstile) -> TurnstileEvent:
    """
    Generates example turntsile event
    """
    return TurnstileEvent(
        turnstile_input.station_id, turnstile_input.turnstile_id, 3, datetime.now().isoformat())


def generate_dummy_turnstile() -> Turnstile:
    """
    Generates example Turnstile
    """

    return Turnstile(1, 2)


if __name__ == '__main__':

    with open(KAFKA_PLAINTEXT_PORT_FILE, 'r', encoding='utf8') as file:
        plaintext_port = file.read().strip()

    config = {
        # User-specific properties that you must set
        'bootstrap.servers': f'localhost:{plaintext_port}',

        # Fixed properties
        'acks': 'all'
    }

    # Create Producer instance
    producer = Producer(config)
    turnstile = generate_dummy_turnstile()
    turnstile_event = generate_dummy_event(turnstile)

    turnstile_json = json.dumps(turnstile.__dict__).encode('utf-8')
    turnstile_event_json = json.dumps(turnstile_event.__dict__).encode('utf-8')

    producer.produce(PRODUCER_TOPIC,  turnstile_event_json, turnstile_json,
                     callback=delivery_callback)

# Block until the messages are sent.
producer.poll(10000)
producer.flush()
