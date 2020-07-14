#!/bin/bash

set -o nounset \
    -o errexit

name=$1
password=`openssl rand -base64 96 | head -c 32`

docker run -v `pwd`/:/openssl -w /openssl \
	openjdk:11 openssl genrsa \
	-passout "pass:${password}" \
	-out "${name}.key" \
	2048

docker run -v `pwd`/:/openssl -w /openssl \
	openjdk:11 openssl req \
	-passin "pass:${password}" \
	-key "${name}.key" \
	-new \
	-out "${name}.csr" \
	-subj '/CN=${name}.local.kafkatastic.com /OU=K7N /O=Kubertron Ltd /L=Letchworth /C=GB'

docker run -v `pwd`/:/openssl -w /openssl \
	openjdk:11 openssl x509 \
	-req \
	-CA ca.crt \
	-CAkey ca.key \
	-in "${name}.csr" \
	-out "${name}.crt" \
	-days 9999 \
	-CAcreateserial \
	-passin pass:kubertronca

echo "${password}" > "${name}.creds"
