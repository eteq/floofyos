# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY system_files /system_files
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/bazzite-nvidia:stable

ARG IMAGE_NAME=floofyos

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
  /ctx/update-image-info.sh && \
  /ctx/install-packages.sh && \
  /ctx/services.sh && \
  /ctx/fix-opt.sh && \
  /ctx/build-initramfs.sh && \
  /ctx/cleanup.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
