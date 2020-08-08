#!/bin/bash

set -euo pipefail

ECO_UID=$(stat -c '%u' /srv/eco)
ECO_GID=$(stat -c '%g' /srv/eco)

echo "Calling 'gosu ${ECO_UID}:${ECO_GID} \"$@\"'" >&2
gosu ${ECO_UID}:${ECO_GID} "$@"
