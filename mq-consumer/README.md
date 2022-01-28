# Purpose
Connect via TLS to the leader and reads all available messages, then quits
TODO: take from there and dump into Kafka

# To run the consumer
export DYLD_LIBRARY_PATH=/opt/mqm/lib64
node index.js
