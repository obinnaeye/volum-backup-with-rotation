#!/bin/bash

# Configuration
VOLUME_PATH="/var/globaleaks" ## Please provide your actual volume path
BACKUP_DIR="./backup"
CONTAINER_NAME="globaleaks"

# Get current date
DATE=$(date +%Y%m%d%H%M%S)

# Uncomment this to stop the container if required
# docker stop ${CONTAINER_NAME}

docker run --rm --volumes-from ${CONTAINER_NAME} -v ${BACKUP_DIR}/7d:/backup ubuntu \
    tar czvf /backup/${CONTAINER_NAME}_${DATE}.tar.gz -C ${VOLUME_PATH} .

# Rotate backups
# 7d to 5w
find "${BACKUP_DIR}/7d" -type f -mtime +7 -exec mv {} "${BACKUP_DIR}/5w/" \;

# 5w to 6m
find "${BACKUP_DIR}/5w" -type f -mtime +35 -exec mv {} "${BACKUP_DIR}/6m/" \;

# 6m to 1y
find "${BACKUP_DIR}/6m" -type f -mtime +180 -exec mv {} "${BACKUP_DIR}/1y/" \;

# Remove old Yearly backups
find "${BACKUP_DIR}/1y" -type f -mtime +365 -exec rm {} \;

# Uncomment this to start the container if you stopped it
# docker start ${CONTAINER_NAME}
