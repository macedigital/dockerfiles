#!/usr/bin/env bash
set -eo pipefail

# suppresses "unable to install syscall filter: seccomp unavailable: your kernel is buggy and you should upgrade"
# @link https://github.com/docker-library/elasticsearch/issues/98
OPTS=" -Des.bootstrap.seccomp=false \
  -Des.path.home=${ES_HOME} \
  -Des.path.conf=${CONF_DIR} \
  -Des.path.data=${DATA_DIR} \
  -Des.path.logs=${LOG_DIR} \
  -Des.network.host=${HOSTNAME} \
  -Des.transport.tcp.port=9300 \
  -Des.http.port=9200"

if [ -n "${CLUSTER}" ]; then
  OPTS="${OPTS} -Des.cluster.name=${CLUSTER}"
  if [ -n "${CLUSTER_FROM}" ]; then
    if [ -d ${DATA_DIR}/${CLUSTER_FROM} -a ! -d ${DATA_DIR}/${CLUSTER} ]; then
      echo "Performing cluster data migration from ${CLUSTER_FROM} to ${CLUSTER}"
      mv ${DATA_DIR}/${CLUSTER_FROM} ${DATA_DIR}/${CLUSTER}
    fi
  fi
fi

if [ -n "${NODE_NAME}" ]; then
  OPTS="${OPTS} -Des.node.name=${NODE_NAME}"
fi

if [ -n "${MULTICAST}" ]; then
  OPTS="${OPTS} -Des.discovery.zen.ping.multicast.enabled=${MULTICAST}"
  PLUGINS="$PLUGINS,discovery-multicast"
fi

if [ -n "$UNICAST_HOSTS" ]; then
  OPTS="${OPTS} -Des.discovery.zen.ping.unicast.hosts=${UNICAST_HOSTS}"
fi

if [ -n "${PUBLISH_AS}" ]; then
  OPTS="${OPTS} -Des.transport.publish_host=$(echo ${PUBLISH_AS} | awk -F: '{print $1}')"
  OPTS="${OPTS} -Des.transport.publish_port=$(echo ${PUBLISH_AS} | awk -F: '{if ($2) print $2; else print 9300}')"
fi

if [ -n "${PLUGINS}" ]; then
  for plugin in $(echo $PLUGINS | awk -v RS=, '{print}')
  do
    echo "Installing the plugin ${plugin}"
    ${ES_HOME}/bin/plugin install ${plugin}
  done
fi

echo "Starting elasticsearch with ${OPTS}"
exec ${ES_HOME}/bin/elasticsearch ${OPTS}
exit $?
