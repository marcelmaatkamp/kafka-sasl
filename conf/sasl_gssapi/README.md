https://docs.confluent.io/current/installation/docker/operations/external-volumes.html

docker run -d \
  --name=kafka-sasl-ssl-1 \
  --net=host \
  -e KAFKA_BROKER_ID=1 \
  -e KAFKA_ZOOKEEPER_CONNECT=localhost:22181,localhost:32181,localhost:42181/saslssl \
  -e KAFKA_ADVERTISED_LISTENERS=SASL_SSL://localhost:39094 \
  -e KAFKA_SSL_KEYSTORE_FILENAME=kafka.broker3.keystore.jks \
  -e KAFKA_SSL_KEYSTORE_CREDENTIALS=broker3_keystore_creds \
  -e KAFKA_SSL_KEY_CREDENTIALS=broker3_sslkey_creds \
  -e KAFKA_SSL_TRUSTSTORE_FILENAME=kafka.broker3.truststore.jks \
  -e KAFKA_SSL_TRUSTSTORE_CREDENTIALS=broker3_truststore_creds \
  -e KAFKA_SECURITY_INTER_BROKER_PROTOCOL=SASL_SSL \
  -e KAFKA_SASL_MECHANISM_INTER_BROKER_PROTOCOL=GSSAPI \
  -e KAFKA_SASL_ENABLED_MECHANISMS=GSSAPI \
  -e KAFKA_SASL_KERBEROS_SERVICE_NAME=kafka \
  -e KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR=1 \
  -e KAFKA_OPTS=-Djava.security.auth.login.config=/etc/kafka/secrets/host_broker3_jaas.conf -Djava.security.krb5.conf=/etc/kafka/secrets/host_krb.conf \
  -v /vol007/kafka-node-1-secrets:/etc/kafka/secrets \
  confluentinc/cp-kafka:latest
