#!/bin/bash

set -o nounset \
    -o errexit

name=$1
password=`openssl rand -base64 96 | head -c 32`

# Create keystores
docker run -v `pwd`/:/keytool -w /keytool \
  openjdk:11 keytool \
	-genkey -noprompt \
	-alias "${name}" \
	-dname "CN=${name}.local.kafkatastic.com, OU=K7N, O=Kubertron Ltd, L=Letchworth, C=GB" \
	-keystore "${name}.keystore.jks" \
	-keyalg RSA \
	-keysize 4096 \
	-storepass "${password}" \
	-keypass "${password}"

# Import CA cert
docker run -v `pwd`/:/keytool -w /keytool \
  openjdk:11 keytool \
  -import \
  -trustcacerts \
  -alias ca \
  -noprompt \
  -storepass "${password}" \
  -keystore "${name}.keystore.jks" \
  -file ./ca.crt

# Create CSR
docker run -v `pwd`/:/keytool -w /keytool \
  openjdk:11 keytool \
  -certreq \
  -alias "${name}" \
  -storepass "${password}" \
  -keystore "${name}.keystore.jks" \
  -file "./${name}.keystore.csr" \
  -dname "c=GB, st=England, l=Letchworth, o=Kubertron Ltd, ou=K7N, cn=${name}.local.kafkatastic.com"

# Sign CSR
docker run -v `pwd`/:/openssl -w /openssl \
	openjdk:11 openssl x509 \
	-req \
	-CA ca.crt \
	-CAkey ca.key \
	-in "${name}.keystore.csr" \
	-out "${name}.keystore.crt" \
	-days 9999 \
	-CAcreateserial \
	-passin pass:kubertronca

docker run -v `pwd`/:/keytool -w /keytool \
  openjdk:11 keytool \
  -import \
  -alias "${name}" \
  -noprompt \
  -storepass "${password}" \
  -keystore "${name}.keystore.jks" \
  -file "./${name}.keystore.crt"

echo "${password}" > "${name}.keystore.creds"
echo "${password}" > "${name}.sslkey.creds"
