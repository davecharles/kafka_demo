#!/bin/bash

set -o nounset \
    -o errexit

# Generate CA key
docker run -v `pwd`/:/openssl -w /openssl \
	openjdk:11 openssl req \
	-new \
	-x509 \
	-keyout ca.key \
	-out ca.crt \
	-days 365 \
	-subj '/CN=ca.local.kafkatastic.com/OU=K7N/O=Kubertron/L=Letchworth/C=GB' \
	-passin pass:kubertronca \
	-passout pass:kubertronca
