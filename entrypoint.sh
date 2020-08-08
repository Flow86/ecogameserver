#!/bin/bash

set -euo pipefail

ECO_UID=$(stat -c '%u' /srv/eco)
ECO_GID=$(stat -c '%g' /srv/eco)

# do we have a group name
if [ -z "$(getent group ${ECO_GID})" ] ; then
    groupadd -g $ECO_GID eco
fi

# do we have a user name?
if [ -z "$(getent passwd ${ECO_UID})" ] ; then
    useradd -u ${ECO_UID} -m -s /bin/bash -g ${ECO_GID} eco
fi

echo "Calling 'gosu ${ECO_UID}:${ECO_GID} \"$@\"'" >&2
gosu ${ECO_UID}:${ECO_GID} "$@"
