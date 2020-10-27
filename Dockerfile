FROM docker:stable-git

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION:-1.18.165}

RUN apk --no-cache add bash openssl gettext curl python3 \
    && curl -s https://bootstrap.pypa.io/get-pip.py | python3 - \
    && pip install --no-cache-dir awscli==${AWS_CLI_VERSION}
