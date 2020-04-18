#!/bin/bash

set -ex

USER_NAME=docker
GROUP_NAME=docker

echo "Running as $UID $GID"

#UID=$(id -u)
#GID=$(id -g)

# do we have a group name
if [ -z "$(id -un)" ] ; then
    groupadd -g $GID $GROUP_NAME
fi

# do we have a user name?
if [ -z "$(id -gn)" ] ; then
    useradd -u $UID -m -s /bin/bash -g $GID $USER_NAME
fi

exec "$@"
