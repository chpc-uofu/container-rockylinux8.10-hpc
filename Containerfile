# syntax=docker/dockerfile:1
FROM docker.io/rockylinux/rockylinux:8.10

# Image build arguments:
ARG imageversion="localdev"
ARG pkgfile=packages.txt

# Labels
LABEL org.opencontainers.image.authors="UofU CHPC <helpdesk@chpc.utah.edu>"
LABEL org.opencontainers.image.description="A custom container image for testing apps in HPC for the CHPC General Environment."
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.title="container-rockylinux8.10-hpc"
LABEL org.opencontainers.image.url="https://github.com/chpc-uofu/container-rockylinux8.10-hpc"
LABEL org.opencontainers.image.vendor="chpc.utah.edu"
LABEL org.opencontainers.image.version=${imageversion}

# Copy external files:
COPY ./files/${pkgfile} /tmp/packages.txt

# Package installs/updates:
RUN dnf -y update; \
    dnf -y install dnf-plugins-core; \
    dnf -y config-manager --set-enabled powertools; \
    dnf -y install \
      epel-release \
      rpmfusion-free-release; \
    dnf -y clean all; \
    dnf -y update
# RUN dnf -y group install 'Standard'; \
#     dnf -y group install 'Server with GUI'; \
#     dnf -y group install 'Development Tools'
RUN dnf -y install --allowerasing $(cat /tmp/packages.txt)

# Cleanup:
RUN rm /tmp/packages.txt
