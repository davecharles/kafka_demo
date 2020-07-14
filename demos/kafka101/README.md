# Kafka 101

This folder contains the Kafka 101 project defaults with vanilla:

- Makefile
- docker-compose.yaml

Follow the default steps:

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

```bash
$ python scripts/publish-weather.py
```

```bash
$ python scripts/consume-weather.py
```
