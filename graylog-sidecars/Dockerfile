FROM debian:10

RUN apt-get update
RUN apt-get -y install curl wget apt-utils apt-transport-https lsb-release gnupg lsof gettext-base
RUN apt-get -y install nano openssl libapr1 libdbi1 libexpat1 ca-certificates systemd systemd-sysv dbus dbus-user-session

RUN wget https://packages.graylog2.org/repo/packages/graylog-sidecar-repository_1-5_all.deb
RUN dpkg -i graylog-sidecar-repository_1-5_all.deb
RUN apt-get update && apt-get install graylog-sidecar
RUN graylog-sidecar -service install

RUN curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.8.2-amd64.deb
RUN dpkg -i filebeat-8.8.2-amd64.deb

RUN rm graylog-sidecar-repository_1-5_all.deb
RUN rm filebeat-8.8.2-amd64.deb

# Define default environment values
ENV GS_NODE_ID="file:/etc/graylog/sidecar/node-id" \
    GS_UPDATE_INTERVAL=10 \
    GS_TLS_SKIP_VERIFY="true" \
    GS_SEND_STATUS="true" \
    GS_CACHE_PATH="/var/cache/graylog-sidecar" \
    GS_LOG_PATH="/var/log/graylog-sidecar" \
    GS_LOG_ROTATE_MAX_FILE_SIZE="10MiB" \
    GS_LOG_ROTATE_KEEP_FILES=10 \
    GS_LIST_LOG_FILES="[]" \
    GS_COLLECTOR_VALIDATION_TIMEOUT="1m" \
    GS_COLLECTOR_SHUTDOWN_TIMEOUT="10s" \
    GS_COLLECTOR_CONFIGURATION_DIRECTORY="/var/lib/graylog-sidecar/generated" \
    GS_TAGS="[]"

ADD ./config /config
RUN chmod +x /config/*

ENTRYPOINT /config/start.sh
# ENTRYPOINT service graylog-sidecar start && service filebeat start && tail -f /dev/null