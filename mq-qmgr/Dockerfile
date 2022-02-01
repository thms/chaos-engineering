FROM ibmcom/mq as qmgr
USER root
RUN microdnf install -y iproute iputils iptables ipset
USER 1001
ENTRYPOINT ["runmqdevserver"]
