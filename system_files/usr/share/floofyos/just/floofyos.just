# Clean up old packages and Docker/Podman images and volumes
clean-floof:
    #!/usr/bin/env bash
    set -uxo pipefail

    echo "Cleaning up system..."
    podman system prune -af
    flatpak uninstall --unused
    rpm-ostree cleanup -bm
    sudo podman system prune -af
    sudo docker system prune -af
    pixi clean cache -y