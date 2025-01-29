# syntax=docker/dockerfile:1
FROM docker.io/rockylinux/rockylinux:8.10

# Image build arguments:
ARG imageversion="localdev"

# Labels
LABEL org.opencontainers.image.authors="UofU CHPC <helpdesk@chpc.utah.edu>"
LABEL org.opencontainers.image.description="A custom container image for testing apps in HPC for the CHPC General Environment."
LABEL org.opencontainers.image.licenses="BSD-3-Clause"
LABEL org.opencontainers.image.title="container-rockylinux8.10-hpc"
LABEL org.opencontainers.image.url="https://github.com/chpc-uofu/container-rockylinux8.10-hpc"
LABEL org.opencontainers.image.vendor="chpc.utah.edu"
LABEL org.opencontainers.image.version=${imageversion}
  

# Copy external files:
COPY ./files/dnf-packages.txt /tmp/dnf-packages.txt

# Package installs/updates:
RUN dnf -y update; \
    dnf install -y epel-release; \
    dnf clean -y all; \
    dnf -y update; \
    dnf install -y $(cat /tmp/dnf-packages.txt)

# Cleanup:
RUN rm /tmp/dnf-packages.txt
