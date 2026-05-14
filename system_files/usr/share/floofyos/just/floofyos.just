# Clean up old packages and Docker/Podman images and volumes
clean-floof:
    #!/usr/bin/env bash
    set -uxo pipefail

    echo "Cleaning up system..."
    podman system prune -f
    flatpak uninstall --unused
    rpm-ostree cleanup -bm
    sudo podman system prune -f
    sudo docker system prune -f
    pixi clean cache -y
