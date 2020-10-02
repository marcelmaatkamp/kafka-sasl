# kafka-sasl
This repository contains examples on how to connect to kafka via [Simple Authentication and Security Layer
(SASL)](https://en.wikipedia.org/wiki/Simple_Authentication_and_Security_Layer)

| SASL | Description |
| -- | -- |
| [PLAINTEXT](#PLAINTEXT) | no encryption and authentication |
| [SASL/PLAIN](#SASL/PLAIN) | username/password authentication |
| [SASL/SSL](#SASL/SSL) | ssl encryption |
| [SASL/SCRAM255](#SASL/SCRAM255) | |
| [SASL/SCRAM512](#SASL/SCRAM512) | |
| [SASL/OAUTHBEARER](#SASL/OAUTHBEARER) | oidc (keycloak) authentication |

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

### telegraf-to-kafka
```telegraf.conf
[agent]
  debug = false
  quiet = false
  interval = "2s"

# -----
# input
# -----
[[inputs.cpu]]
  percpu = true
  totalcpu = true
  collect_cpu_time = false
  report_active = false

# -----
# output
# ------
[[outputs.kafka]]
  brokers = ["kafka:9092"]
  topic = "telegraf"
  data_format = "json"
```

### kafka-to-telegraf
```telegraf.conf
[agent]
  debug = false
  quiet = false

# -----
# input
# -----
[[inputs.kafka_consumer]]
  brokers = ["kafka:9092"]
  topics = ["telegraf"]
  data_format = "json"

# -----
# output
# ------
[[outputs.file]]
  files = ["stdout"]
```

## start brokers
```bash
% docker-compose \
   -f conf/plain/docker-compose.yaml \
   up -d kafka &&\
  sleep 10 &&\
  docker-compose \
   -f conf/plain/docker-compose.yaml \
   up telegraf

telegraf_1           | 2020-10-02T07:00:26Z I! Starting Telegraf 1.15.3
telegraf_1           | 2020-10-02T07:00:26Z I! Using config file: /etc/telegraf/telegraf.conf
telegraf_1           | 2020-10-02T07:00:26Z I! Loaded inputs: kafka_consumer
telegraf_1           | 2020-10-02T07:00:26Z I! Loaded aggregators: 
telegraf_1           | 2020-10-02T07:00:26Z I! Loaded processors: 
telegraf_1           | 2020-10-02T07:00:26Z I! Loaded outputs: file
telegraf_1           | 2020-10-02T07:00:26Z I! Tags enabled: host=bffc86bbe931
telegraf_1           | 2020-10-02T07:00:26Z I! [agent] Config: Interval:10s, Quiet:false, Hostname:"bffc86bbe931", Flush Interval:10s
telegraf_1           | kafka_consumer,host=bffc86bbe931 timestamp=1601622032,fields_usage_iowait=0,fields_usage_softirq=0,fields_usage_guest_nice=0,fields_usage_irq=0,fields_usage_guest=0,fields_usage_user=0,fields_usage_nice=0,fields_usage_system=8.695652173784097,fields_usage_idle=91.30434782443646,fields_usage_steal=0 1601622040364040800
telegraf_1           | kafka_consumer,host=bffc86bbe931 timestamp=1601622032,fields_usage_system=4.761904761811956,fields_usage_guest=0,fields_usage_idle=95.23809523710531,fields_usage_user=0,fields_usage_iowait=0,fields_usage_steal=0,fields_usage_nice=0,fields_usage_softirq=0,fields_usage_guest_nice=0,fields_usage_irq=0 1601622040378406400
```
## cleanup 
```bash
% docker-compose -f conf/plain/docker-compose.yaml down -v --remove-orphans
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

