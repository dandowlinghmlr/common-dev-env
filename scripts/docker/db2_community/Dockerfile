FROM docker.io/hmlandregistry/db2-cgroupaware:11.5.9.0

EXPOSE 50000 55000

VOLUME /database

HEALTHCHECK --interval=10s --start-period=20s --retries=40  \
  CMD /database/config/$DB2INSTANCE/sqllib/bin/db2gcf -s && [ -f /var/readiness/ready ] && echo 'File is present'
