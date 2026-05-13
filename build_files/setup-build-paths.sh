#!/usr/bin/bash

set -uexo pipefail

mkdir -p /var/roothome
ln -s /build_cache /var/cache
ln -s /build_logs /var/log