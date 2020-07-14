# Kafka 102

This folder contains updated files for the Kafka 102 demo. This demo
introduces secure communications with the Kafka Broker over SSL. 

## Makefile
Updated to add and use the `create-keys` target. This means that when we
`make compose-build` we will create the necessary certificates and keys
for SSL connection to kafka. 

## docker-compose.yaml
Updated to add:
- `KAFKA_ADVERTISED_LISTENERS` to include SSL endpoints
- `KAFKA_SSL_*` environment variables
- A shared volume to share the certs between the kafka components

Follow the usual steps:

```bash
$ make compose-build
$ make compose-up
```

Navigate a browser to `http://localhost:8000`. This is the Kafka Topics UI.
Initially it will look pretty bare. Execute: 

```bash
$ make compose-exec
```

This will drop you onto a container command-line. The container image
provides all the dependencies you need. From here you can run a script to
publish some weather stats to the `kubertron.weather.inbound` topic, and run
a script to consume those stats.

This time, run the SSL ready versions of the publisher and subscriber.

```bash
$ python scripts/publish-weather-secure.py
```

```bash
$ python scripts/consume-weather-secure.py
```
