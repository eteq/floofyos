#!/bin/bash

set -uexo pipefail


systemctl enable docker.socket
systemctl enable podman.socket
systemctl enable ublue-system-setup.service

systemctl enable uupd.timer


# not sure if these are necessary, but these are things that are enabled in some bazzite settings, so just in case...
systemctl disable input-remapper.service
systemctl disable bazzite-autologin.service