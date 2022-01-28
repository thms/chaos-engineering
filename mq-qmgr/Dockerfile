FROM ibmcom/mq as qmgr
USER root
RUN microdnf install -y iproute iputils 
USER 1001
ENTRYPOINT ["runmqdevserver"]
