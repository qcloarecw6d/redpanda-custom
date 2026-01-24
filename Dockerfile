ARG REDPANDA_VERSION=25.3.6
FROM --platform=linux/amd64 docker.redpanda.com/redpandadata/redpanda:v${REDPANDA_VERSION}

USER root

RUN echo '#!/bin/bash\nulimit -n 65536\nexec /opt/redpanda/bin/redpanda-original "$@"' > /tmp/redpanda-wrapper && \
    chmod +x /tmp/redpanda-wrapper && \
    cp /opt/redpanda/bin/redpanda /opt/redpanda/bin/redpanda-original && \
    cp /tmp/redpanda-wrapper /opt/redpanda/bin/redpanda && \
    chmod +x /opt/redpanda/bin/redpanda

USER redpanda

CMD ["rpk", "redpanda", "start", "--overprovisioned"] 
