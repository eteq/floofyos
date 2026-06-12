#!/usr/bin/bash

set -uexo pipefail

mkdir -p /var/roothome
ln -s /build_cache /var/cache
ln -s /build_logs /var/log

# Copy the contents of system_files/ of the git repo to /
cp -avf "/run/context/system_files"/. /