ARG DOCKER_VERSION=20.10.8

FROM docker:${DOCKER_VERSION}-git

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION=1.20.18
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

RUN set -eux; \
    apk --no-cache add bash openssl gettext curl python3; \
    curl -s https://bootstrap.pypa.io/get-pip.py | python3 -; \
    pip install --no-cache-dir awscli==${AWS_CLI_VERSION}

CMD ["bash"]
