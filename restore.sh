#!/bin/bash

# Configuration
VOLUME_PATH="/var/globaleaks" ## Please provide your actual volume path
BACKUP_DIR="./backup"
CONTAINER_NAME="globaleaks"
BACKUP_FILE="$1" # Arg for backup file path

if [ -z "$BACKUP_FILE" ]; then
    echo "Usage: . restore.sh <backup_file>"
    return
fi

# Uncomment this to stop the container if required
# docker stop ${CONTAINER_NAME}

# Restore Volume
docker run --rm --volumes-from ${CONTAINER_NAME} -v ${BACKUP_DIR}/$(dirname $BACKUP_FILE):/backup ubuntu \
  tar xzvf ${BACKUP_DIR}/$(basename $BACKUP_FILE) -C ${VOLUME_PATH}

# Uncomment this to start the container if you stopped it
# docker start ${CONTAINER_NAME}
