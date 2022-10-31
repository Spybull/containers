#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# Load tinode environment
. /opt/tinode/scripts/tinode-env.sh

if [[ "$*" = "/opt/tinode/scripts/run.sh"* ]]; then
    echo "** Starting TINODE setup **"
    /opt/tinode/scripts/setup.sh
    echo "** TINODE setup finished! **"
fi

echo ""
exec "$@"