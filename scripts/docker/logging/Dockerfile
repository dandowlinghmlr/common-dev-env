FROM quay.io/lib/python:3.13.3-slim

ENV PYTHONUNBUFFERED=yes
COPY tini server.py run.sh /
RUN chmod 755 /tini /server.py /run.sh

ENTRYPOINT ["/tini", "-e", "143", "--"]
CMD ["/run.sh"]
