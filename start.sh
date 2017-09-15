#!/bin/sh

addgroup -g ${GID} grim
adduser -s /bin/sh -D -G grim -u ${UID} grim

if [ ! -f /config/grimd.toml ]; then
    cp /grimd.toml /config/grimd.toml
fi

chown -R grim:grim /config

chpst -u grim -U grim -- sh -c "/usr/local/bin/grimd -config /config/grimd.toml -update"
