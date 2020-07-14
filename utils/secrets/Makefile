# Makefile for SSL Certificates.
.PHONY: all clean ca.crt

all:
	$(MAKE) clean
	$(MAKE) ca.crt
	$(MAKE) local.kafka.crt
	$(MAKE) local.kafka.keystore.jks
	$(MAKE) local.kafka.truststore.jks

ca.crt:
	bash create-ca.sh

%.crt: ca.crt
	bash create-certificate.sh $(subst .crt,,$@)

%.keystore.jks: ca.crt
	bash create-keystore.sh $(subst .keystore.jks,,$@)

%.truststore.jks: ca.crt
	bash create-truststore.sh $(subst .truststore.jks,,$@)

clean:
	rm -f *.csr
	rm -f *.srl
	rm -f *.crt
	rm -f *.key
	rm -f *.jks
	rm -f *.creds
