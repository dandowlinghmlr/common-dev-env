FROM icr.io/ibm-messaging/mq:9.3.5.1-r2

# Auto-accept the license
# Create default users and channels
ENV LICENSE=accept \
  MQ_DEV=true \
  MQ_ENABLE_METRICS=false \
  MQ_QMGR_NAME=LOCAL_QM \
  MQ_ADMIN_PASSWORD=passw0rd

# For persistence
VOLUME /mnt/mqm
