FROM debian:buster-slim

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG DOCKER_VERSION
ENV DOCKER_VERSION=${DOCKER_VERSION:-20.10.7}

ARG AWS_CLI_VERSION
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION:-2.2.17}

RUN apt-get update \
    && apt-get install -y --no-install-recommends --no-install-suggests \
    ca-certificates curl wget git unzip groff less \
    && rm -rf /var/lib/apt/lists/* \
    && update-ca-certificates \
    && curl -SfL -o /tmp/docker-cli.deb https://download.docker.com/linux/debian/dists/buster/pool/stable/amd64/docker-ce-cli_${DOCKER_VERSION}~3-0~debian-buster_amd64.deb \
    && dpkg -i /tmp/docker-cli.deb \
    && curl -SfL -o /tmp/awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip \
    && unzip -d /tmp /tmp/awscliv2.zip \
    && /tmp/aws/install \
    && rm -rf /tmp/* \
    && docker --version \
    && aws --version

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
