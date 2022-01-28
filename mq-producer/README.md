# Purpose
The producer connects via TLS to the leader of the NativeHA cluster to publish
a number of messages and measures time elapsed.

# Run the producer
export DYLD_LIBRARY_PATH=/opt/mqm/lib64
node index.js
