# Create TLS key pair for MQ Server
You can create a self-signed certificate for the queue manager, and add the certificate to a key database to act as the truststore for the client.

openssl req -newkey rsa:2048 -nodes -keyout tls.key -subj "/CN=localhost" -x509 -days 3650 -out tls.crt

# Create a TLS private key and certificates for internal use by Native HA
The three pods in a Native HA queue manager replicate data over the network. You can create a self-signed certificate for use when replicating internally. Note that you should only use self-signed certificates for development purposes.

openssl req -newkey rsa:2048 -nodes -keyout nativeha.key -subj "/CN=localhost" -x509 -days 3650 -out nativeha.crt

# Add the queue manager public key to a client key database
A client key database is used as the truststore for the client application.
Create the client key database:

/opt/mqm/bin/runmqakm -keydb -create -db clientkey.kdb -pw password -type cms -stash

Add the previously generated public key to the client key database:

/opt/mqm/bin/runmqakm -cert -add -db clientkey.kdb -label mqservercert -file tls.crt -format ascii -stashed

# Create secret for use in docker .. syntax needs adjusting
docker secret create tls example-ha-secret --key="tls.key" --cert="tls.crt"


MQM expects a key database and password stash in a given directory
the password stash holds the passwords for the key database.
https://www.ibm.com/docs/en/ibm-mq/9.0?topic=mq-ssltls-key-repository
default location
/var/mqm/qmgrs/QM1/ssl
stash: x.sth
key database: .kdb
