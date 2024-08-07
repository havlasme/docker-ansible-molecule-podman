FROM python:3.10-bullseye
LABEL maintainer="Tomáš Havlas"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       podman fuse-overlayfs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install ansible ansible-lint molecule molecule-plugins[podman] yamllint
