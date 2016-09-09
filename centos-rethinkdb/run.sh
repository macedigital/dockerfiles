#!/usr/bin/env bash
set -eo pipefail

# todo: rewrite input arguments

exec /bin/rethinkdb ${@} --config-file /etc/rethinkdb/instances.d/default.conf --no-update-check
