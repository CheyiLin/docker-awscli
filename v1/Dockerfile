ARG DOCKER_VERSION=24.0.7

# dind variant includes git and the git variant is deprecated.
# https://github.com/docker-library/docker/pull/483
FROM docker:${DOCKER_VERSION}-dind

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION=1.29.10
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]
RUN apk --no-cache add bash openssl gettext curl python3 py3-pip jq make; \
    pip install --no-cache-dir --break-system-packages awscli==${AWS_CLI_VERSION}

CMD ["bash"]
