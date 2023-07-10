#!/bin/bash
envsubst </config/sidecar.yml >/etc/graylog/sidecar/sidecar.yml

if [ -n "${GS_NODE_ID_VALUE}" ]
then
    envsubst </config/node-id >/etc/graylog/sidecar/node-id
fi

service graylog-sidecar start && 
service filebeat start &&
tail -f /dev/null