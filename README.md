# kafka-sasl
repository containing examples on how to connect to kafka via sasl

# PLAINTEXT
We begin with no encryption and no authentication aka: "PLAINTEXT"

## kafka
```docker-compose.yml
 kafka:
  environment:
   KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT
   KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://kafka:9092
```

## telegraf
```telegraf.conf
[[outputs.kafka]]
  brokers = ["kafka:9092"]
  topic = "telegraf"
  enable_tls = false
```

## start brokers
```
% docker-compose -f conf/plain/docker-compose.yaml up telegraf kafkacat

kafkacat_1   | % Reached end of topic telegraf [0] at offset 0
telegraf_1   | 2020-10-01T19:22:20Z I! Starting Telegraf 1.15.3
telegraf_1   | 2020-10-01T19:22:20Z I! Using config file: /etc/telegraf/telegraf.conf
telegraf_1   | 2020-10-01T19:22:20Z I! Loaded inputs: cpu disk
telegraf_1   | 2020-10-01T19:22:20Z I! Loaded aggregators: 
telegraf_1   | 2020-10-01T19:22:20Z I! Loaded processors: 
telegraf_1   | 2020-10-01T19:22:20Z I! Loaded outputs: kafka
telegraf_1   | 2020-10-01T19:22:20Z I! Tags enabled: host=1fe156cb2104
telegraf_1   | 2020-10-01T19:22:20Z I! [agent] Config: Interval:10s, Quiet:false, Hostname:"1fe156cb2104", Flush Interval:10s
telegraf_1   | 2020-10-01T19:22:20Z D! [agent] Initializing plugins
telegraf_1   | 2020-10-01T19:22:20Z D! [agent] Connecting outputs
telegraf_1   | 2020-10-01T19:22:20Z D! [agent] Attempting connection to [outputs.kafka]
telegraf_1   | 2020-10-01T19:22:20Z D! [sarama] 
telegraf_1   | 2020-10-01T19:22:20Z D! [sarama] client/metadata fetching metadata for all topics from broker kafka:9092
telegraf_1   | 2020-10-01T19:22:20Z D! [sarama] Connected to broker at kafka:9092 (unregistered)
telegraf_1   | 2020-10-01T19:22:20Z D! [sarama] client/brokers registered new broker #1 at kafka:9092
telegraf_1   | 2020-10-01T19:22:20Z D! [sarama] 
telegraf_1   | 2020-10-01T19:22:20Z D! [agent] Successfully connected to outputs.kafka
telegraf_1   | 2020-10-01T19:22:20Z D! [agent] Starting service inputs
telegraf_1   | 2020-10-01T19:22:30Z D! [sarama] producer/broker/1 starting up
telegraf_1   | 2020-10-01T19:22:30Z D! [sarama] producer/broker/1 state change to [open] on telegraf/0
telegraf_1   | 2020-10-01T19:22:30Z D! [sarama] Connected to broker at kafka:9092 (registered as #1)
telegraf_1   | 2020-10-01T19:22:30Z D! [outputs.kafka] Wrote batch of 4 metrics in 37.977ms
telegraf_1   | 2020-10-01T19:22:30Z D! [outputs.kafka] Buffer fullness: 0 / 10000 metrics
kafkacat_1   | % Reached end of topic telegraf [0] at offset 4
telegraf_1   | 2020-10-01T19:22:40Z D! [outputs.kafka] Wrote batch of 9 metrics in 9.638ms
kafkacat_1   | 
kafkacat_1   | Key (-1 bytes):   
kafkacat_1   | Value (309 bytes): {"fields":{"free":45815668736,"inodes_free":3447618,"inodes_total":3907584,"inodes_used":459966,"total":62725623808,"used":13693239296,"used_percent":23.010402557944218},"name":"disk","tags":{"device":"vda1","fstype":"ext4","host":"1fe156cb2104","mode":"rw","path":"/etc/resolv.conf"},"timestamp":1601580150}
kafkacat_1   | 
kafkacat_1   |  artition: 0    Offset: 0
kafkacat_1   | --
```

# SASL/PLAIN
Now we add authentication

## kafka
```docker-compose.yml
 kafka:
  environment:
   SECURITY_PLUGINS_OPTS=-Djava.security.auth.login.config=/etc/schema-registry/kafka_client_jaas.conf
   KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: SASL_PLAIN:SASL_PLAIN
   KAFKA_ADVERTISED_LISTENERS: SASL_PLAIN://kafka:9093
```

## telegraf
```telegraf.conf
```

# SASL/SSL
Now we add SSL encryption:

## kafka
```docker-compose.yml
 kafka:
  environment:
   SECURITY_PLUGINS_OPTS=-Djava.security.auth.login.config=/etc/schema-registry/kafka_client_jaas.conf
   KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: SASL_SSL:SASL_SSL
   KAFKA_ADVERTISED_LISTENERS: SASL_SSL://kafka:9093
```

## telegraf
```telegraf.conf
```

# SASL/SCRAM255

## kafka
```docker-compose.yml
```

## telegraf
```telegraf.conf
```

# SASL/SCRAM512

## kafka
```docker-compose.yml
```

## telegraf
```telegraf.conf
```

# SASL/GSSAPI aka Kerberos

## kafka
```docker-compose.yml
```

## telegraf
```telegraf.conf
```

# SASL/OAUTHBEARER

## kafka
```docker-compose.yml
```

## telegraf
```telegraf.conf
```

