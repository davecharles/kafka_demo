# Makefile for Kafka 1xx demos.
.PHONY: help create-keys compose-build compose-up compose-down

SHELL = /bin/zsh
COMPOSE ?= docker-compose

help:
	@echo "create-keys          - Create certs for Kafka SSL"
	@echo "compose-build        - Docker compose build"
	@echo "compose-up           - Docker compose up"
	@echo "compose-down         - Docker compose down"

create-keys:
	rm -rf certs/ && mkdir certs/
	$(MAKE) -C ./utils/secrets/ all
	mv ./utils/secrets/*.{csr,key,crt,srl,creds,jks} certs/

load-schemas:
	$(COMPOSE) exec service python schemas/load.py

compose-build:
	$(MAKE) create-keys
	$(COMPOSE) build

compose-up:
	$(COMPOSE) up -d

compose-down:
	$(COMPOSE) down
