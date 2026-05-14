#!/usr/bin/bash

set -uexo pipefail

IMAGE_INFO="/usr/share/ublue-os/image-info.json"
IMAGE_REF="ostree-image-signed:docker://ghcr.io/eteq/$IMAGE_NAME"

# image-info File
sed -i 's/"image-name": [^,]*/"image-name": "'"$IMAGE_NAME"'"/' $IMAGE_INFO
sed -i 's/"image-vendor": [^,]*/"image-vendor": "eteq"/' $IMAGE_INFO
sed -i 's|"image-ref": [^,]*|"image-ref": "'"$IMAGE_REF"'"|' $IMAGE_INFO
sed -i 's|"image-tag": [^,]*|"image-tag": "latest"|' $IMAGE_INFO
sed -i 's|"image-branch": [^,]*|"image-branch": ""|' $IMAGE_INFO

# OS Release File
sed -i 's/^VARIANT_ID=.*/VARIANT_ID="'"$IMAGE_NAME"'"/' /usr/lib/os-release
sed -i 's/^ID=bazzite/ID=floofyos/' /usr/lib/os-release
sed -i 's/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME="floofyos"/' /usr/lib/os-release
sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="FloofyOS"/' /usr/lib/os-release
sed -i 's/^HOME_URL=.*/HOME_URL="https:\/\/github.com\/eteq\/floofyos"/' /usr/lib/os-release

# KDE About page
sed -i "s|^Website=.*|Website=https:\/\/github.com\/eteq\/floofyos|" /etc/xdg/kcm-about-distrorc
sed -i "s/^Variant=.*/Variant=$IMAGE_NAME/" /etc/xdg/kcm-about-distrorc
