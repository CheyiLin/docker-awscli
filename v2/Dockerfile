FROM ubuntu:20.04

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG TARGETOS
ARG TARGETARCH

ARG DOCKER_DL_BASE=https://download.docker.com/linux/ubuntu/dists/focal/pool/stable

ARG DOCKER_VERSION=24.0.5
ENV DOCKER_VERSION=${DOCKER_VERSION}

ARG DOCKER_BUILDX_VERSION=0.11.2
ENV DOCKER_BUILDX_VERSION=${DOCKER_BUILDX_VERSION}

ARG DOCKER_COMPOSE_VERSION=2.20.2
ENV DOCKER_COMPOSE_VERSION=${DOCKER_COMPOSE_VERSION}

ARG AWS_CLI_VERSION=2.13.3
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]
RUN apt-get update; \
    apt-get install -y --no-install-recommends --no-install-suggests \
        ca-certificates curl wget git unzip groff less jq make; \
    rm -rf /var/lib/apt/lists/*; \
    update-ca-certificates; \
    \
    curl -SfL -o /tmp/docker-ce-cli.deb \
        "${DOCKER_DL_BASE}/${TARGETARCH}/docker-ce-cli_${DOCKER_VERSION}-1~ubuntu.20.04~focal_${TARGETARCH}.deb"; \
    curl -SfL -o /tmp/docker-buildx-plugin.deb \
        "${DOCKER_DL_BASE}/${TARGETARCH}/docker-buildx-plugin_${DOCKER_BUILDX_VERSION}-1~ubuntu.20.04~focal_${TARGETARCH}.deb"; \
    curl -SfL -o /tmp/docker-compose-plugin.deb \
        "${DOCKER_DL_BASE}/${TARGETARCH}/docker-compose-plugin_${DOCKER_COMPOSE_VERSION}-1~ubuntu.20.04~focal_${TARGETARCH}.deb"; \
    dpkg -i /tmp/docker-ce-cli.deb /tmp/docker-buildx-plugin.deb /tmp/docker-compose-plugin.deb; \
    rm -f /tmp/docker-*.deb; \
    \
    curl -SfL -o /tmp/awscliv2.zip \
        "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m)-${AWS_CLI_VERSION}.zip"; \
    unzip -d /tmp /tmp/awscliv2.zip; \
    /tmp/aws/install; \
    rm -rf /tmp/aws*

# make it acts like official docker images
# https://github.com/docker-library/docker/blob/master/20.10/Dockerfile
COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

# https://github.com/docker-library/docker/pull/166
#   dockerd-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-generating TLS certificates
#   docker-entrypoint.sh uses DOCKER_TLS_CERTDIR for auto-setting DOCKER_TLS_VERIFY and DOCKER_CERT_PATH
# (For this to work, at least the "client" subdirectory of this path needs to be shared between the client and server containers via a volume, "docker cp", or other means of data sharing.)
ENV DOCKER_TLS_CERTDIR=/certs
# also, ensure the directory pre-exists and has wide enough permissions for "dockerd-entrypoint.sh" to create subdirectories, even when run in "rootless" mode
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client
# (doing both /certs and /certs/client so that if Docker does a "copy-up" into a volume defined on /certs/client, it will "do the right thing" by default in a way that still works for rootless users)

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
