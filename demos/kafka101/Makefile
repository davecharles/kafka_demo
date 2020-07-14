# Makefile for Kafka 101 demo.
.PHONY: help compose-build compose-up compose-down

SHELL = /bin/zsh
COMPOSE ?= docker-compose

help:
	@echo "compose-build        - Docker compose build"
	@echo "compose-up           - Docker compose up"
	@echo "compose-down         - Docker compose down"

compose-build:
	$(COMPOSE) build

compose-up:
	$(COMPOSE) up -d

compose-down:
	$(COMPOSE) down
