ARG DOCKER_VERSION=24.0.7

FROM docker:${DOCKER_VERSION}-git

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION=1.29.10
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]
RUN apk --no-cache add bash openssl gettext curl python3 py3-pip jq make; \
    pip install --no-cache-dir --break-system-packages awscli==${AWS_CLI_VERSION}

CMD ["bash"]
