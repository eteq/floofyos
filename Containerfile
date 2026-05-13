# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

COPY system_files /system_files
COPY build_files /

# Base Image
FROM ghcr.io/ublue-os/bazzite-nvidia:stable as floofyos

ARG IMAGE_NAME=floofyos


RUN --mount=type=bind,from=ctx,source=/,target=/run/context \
    --mount=type=cache,dst=/build_cache \
    --mount=type=cache,dst=/build_logs \
    --mount=type=tmpfs,dst=/tmp \
  /run/context/setup-build-paths.sh && \
  /run/context/update-image-info.sh && \
  /run/context/install-packages.sh && \
  /run/context/services.sh && \
  /run/context/fix-opt.sh && \
  /run/context/build-initramfs.sh && \
  /run/context/cleanup.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
