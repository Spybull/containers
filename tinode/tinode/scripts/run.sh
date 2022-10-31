#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/tinode/scripts/tinode-env.sh

if [[ ! -f "$TINODE_MAIN_CONFIG" ]]; then
    echo "ERR: $TINODE_MAIN_CONFIG not found!"
    exit 1
fi

args=("--config=${TINODE_MAIN_CONFIG}" "--static_data=${TINODE_STATIC_DIR}")

# Run and drop user privs
exec su-exec tinode ${TINODE_EXE_FILE} "${args[@]}"