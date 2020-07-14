# Kafka 103

This folder contains updated files for the Kafka 103 demo. This demo
introduces Avro schemas and the Kafka Schema registry.  

## Makefile
Updated to add and use the `load-schemas` target.

## docker-compose.yaml
Updated to add service:
- `kafka-schema-registry`
- `kafka-schema-registry-ui`

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

This time, run the schema aware ready versions of the publisher and subscriber.

```bash
$ python scripts/publish-weather-avro.py
```

```bash
$ python scripts/consume-weather-avro.py
```
