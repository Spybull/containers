#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

. /opt/tinode/scripts/tinode-env.sh

# If external configuration is set
if [ ! -z "${TINODE_EXTERNAL_CONFIG}" ]; then
    TINODE_MAIN_CONFIG="${TINODE_EXTERNAL_CONFIG}"
else
    # Set config file env
    while IFS='' read -r line || [[ -n $line ]]; do
        while [[ "$line" =~ (\$[A-Z_][A-Z_0-9]*) ]]; do
            LHS=${BASH_REMATCH[1]}
            RHS="$(eval echo "\"$LHS\"")"
            line=${line//$LHS/$RHS}
        done
        echo "$line" >> "${TINODE_MAIN_CONFIG}"
    done < "${TINODE_TPL_CONFIG}"

    # Remove tpl config
    rm -f ${TINODE_TPL_CONFIG}
fi

# Do not load data when upgrading database.
if [ "$TINODE_UPGRADE_DB" = "true" ] ; then
	TINODE_SAMPLE_DATA=
fi

# Initialize empty database
init_stdout=${TINODE_BASE_DIR}/init-db-stdout.txt
${TINODE_BASE_DIR}/init-db \
                        --reset=${TINODE_RESET_DB} \
                        --upgrade=${TINODE_UPGRADE_DB} \
                        --config=${TINODE_MAIN_CONFIG} \
                        --data=${TINODE_SAMPLE_DATA} \
                        --no_init=${TINODE_NO_DB_INIT}
                        1>$init_stdout
if [ $? -ne 0 ]; then
    echo "init-db failed. Quitting."
    exit 1
fi

#If sample data was provided, try to find Tino password.
if [ ! -z "$TINODE_SAMPLE_DATA" ] ; then
	grep "usr;tino;" $init_stdout > ${BOT_DIR}/tino-password || true
fi

if [ -s "${BOT_DIR}/tino-password" ] ; then
	# Convert Tino's authentication credentials into a cookie file.

	# /botdata/tino-password could be empty if DB was not updated. In such a case the
	# /botdata/.tn-cookie will not be modified.
	${TINODE_BASE_DIR}/credentials.sh ${BOT_DIR}/.tn-cookie < ${BOT_DIR}/tino-password
fi

# Drop all privs
chown -R root.tinode "${TINODE_BASE_DIR}"
chmod -R g+rwX,o= "${TINODE_BASE_DIR}"

chown -R root.tinode "${BOT_DIR}"
chmod -R g+rwX,o= "${BOT_DIR}"

chmod g+rX "${TINODE_STATIC_DIR}"
chmod -R 0660 "${BOT_DIR}"
chmod 0750 ${TINODE_BASE_DIR}/init-db ${TINODE_BASE_DIR}/keygen ${TINODE_BASE_DIR}/credentials.sh ${TINODE_BASE_DIR}/tinode
exit 0