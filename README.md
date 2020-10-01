# kafka-sasl
repository containing examples on how to connect to kafka via sasl

# plain text

## telegraf-plain.conf
```telegraf-plain.conf
[[outputs.kafka]]
  brokers = ["kafka:9092"]
  topic = "telegraf"
  enable_tls = false
```

## start brokers
```
% docker-compose -f docker-compose-plain.yaml up -d kafka
% docker-compose -f docker-compose-plain.yaml up telegraf kafkacat

telegraf_1   | 2020-10-01T06:07:49Z I! Starting Telegraf 1.15.3
telegraf_1   | 2020-10-01T06:07:49Z I! Using config file: /etc/telegraf/telegraf.conf
telegraf_1   | 2020-10-01T06:07:49Z I! Loaded inputs: cpu disk
telegraf_1   | 2020-10-01T06:07:49Z I! Loaded aggregators: 
telegraf_1   | 2020-10-01T06:07:49Z I! Loaded processors: 
telegraf_1   | 2020-10-01T06:07:49Z I! Loaded outputs: kafka
telegraf_1   | 2020-10-01T06:07:49Z I! Tags enabled: host=0552d02c50aa
telegraf_1   | 2020-10-01T06:07:49Z I! [agent] Config: Interval:10s, Quiet:false, Hostname:"0552d02c50aa", Flush Interval:10s
telegraf_1   | 2020-10-01T06:07:49Z D! [agent] Initializing plugins
telegraf_1   | 2020-10-01T06:07:49Z D! [agent] Connecting outputs
telegraf_1   | 2020-10-01T06:07:49Z D! [agent] Attempting connection to [outputs.kafka]
telegraf_1   | 2020-10-01T06:07:49Z D! [sarama] 
telegraf_1   | 2020-10-01T06:07:49Z D! [sarama] client/metadata fetching metadata for all topics from broker kafka:9092
telegraf_1   | 2020-10-01T06:07:49Z D! [sarama] Connected to broker at kafka:9092 (unregistered)
telegraf_1   | 2020-10-01T06:07:49Z D! [sarama] client/brokers registered new broker #1 at kafka:9092
telegraf_1   | 2020-10-01T06:07:49Z D! [sarama] 
telegraf_1   | 2020-10-01T06:07:49Z D! [agent] Successfully connected to outputs.kafka
telegraf_1   | 2020-10-01T06:07:49Z D! [agent] Starting service inputs
kafkacat_1   | % Reached end of topic telegraf [0] at offset 4
telegraf_1   | 2020-10-01T06:07:59Z D! [sarama] producer/broker/1 starting up
telegraf_1   | 2020-10-01T06:07:59Z D! [sarama] producer/broker/1 state change to [open] on telegraf/0
telegraf_1   | 2020-10-01T06:07:59Z D! [sarama] Connected to broker at kafka:9092 (registered as #1)
telegraf_1   | 2020-10-01T06:07:59Z D! [outputs.kafka] Wrote batch of 4 metrics in 18.7086ms
telegraf_1   | 2020-10-01T06:07:59Z D! [outputs.kafka] Buffer fullness: 0 / 10000 metrics
kafkacat_1   | % Reached end of topic telegraf [0] at offset 8
kafkacat_1   | 
kafkacat_1   | Key (-1 bytes):   
kafkacat_1   | Value (309 bytes): {"fields":{"free":45770866688,"inodes_free":3445876,"inodes_total":3907584,"inodes_used":461708,"total":62725623808,"used":13738041344,"used_percent":23.085688846134733},"name":"disk","tags":{"device":"vda1","fstype":"ext4","host":"0552d02c50aa","mode":"rw","path":"/etc/resolv.conf"},"timestamp":1601532460}
kafkacat_1   | 
kafkacat_1   |  artition: 0    Offset: 0
```
