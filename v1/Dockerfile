ARG DOCKER_VERSION=24.0.5

FROM docker:${DOCKER_VERSION}-git

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION=1.29.10
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

SHELL ["/bin/ash", "-euxo", "pipefail", "-c"]
RUN apk --no-cache add bash openssl gettext curl python3 jq make; \
    curl -s "https://bootstrap.pypa.io/get-pip.py" | python3 -; \
    pip install --no-cache-dir awscli==${AWS_CLI_VERSION}

CMD ["bash"]
