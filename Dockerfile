FROM docker:stable-git

LABEL maintainer="Cheyi Lin <cheyi.lin@gmail.com>"

ARG AWS_CLI_VERSION
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION:-1.16.273}

RUN apk --no-cache add openssl gettext curl python3 \
    && curl -s https://bootstrap.pypa.io/get-pip.py | python3 - \
    && pip install awscli==$AWS_CLI_VERSION
