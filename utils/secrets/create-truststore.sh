#!/bin/bash

set -o nounset \
    -o errexit

name=$1
password=`openssl rand -base64 96 | head -c 32`

docker run -v `pwd`/:/keytool -w /keytool \
  openjdk:11 keytool \
  -import \
  -trustcacerts \
  -alias ca \
  -noprompt \
  -storepass "${password}" \
  -keystore "${name}.truststore.jks" \
  -file ./ca.crt

echo "${password}" > "${name}.truststore.creds"
