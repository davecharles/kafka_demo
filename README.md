# Kafka 1XX Demos

This repository contains a series of simple Kafka demonstrations. Start here
and follow the steps using the `Kafka 101` project files:

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
