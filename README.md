# docker-awscli

Docker in Docker image with AWS CLI v1/v2 support

Upstream releases: [github.com/aws/aws-cli](https://github.com/aws/aws-cli/releases)

[![GitHub Release Date](https://img.shields.io/github/release-date/cheyilin/docker-awscli)](https://github.com/CheyiLin/docker-awscli/releases)

## Supported Platforms

- `linux/amd64`
- `linux/arm64`

## Builds

- [![ci-awscli-v2](https://github.com/CheyiLin/docker-awscli/actions/workflows/ci-awscli-v2.yml/badge.svg)](https://ghcr.io/cheyilin/docker-awscli)
- [![ci-awscli-v1](https://github.com/CheyiLin/docker-awscli/actions/workflows/ci-awscli-v1.yml/badge.svg)](https://ghcr.io/cheyilin/docker-awscli)

## Image Registry

### GitHub Container Registry

```text
ghcr.io/cheyilin/docker-awscli:<version-tag>
```

### Docker Hub [![Docker Pulls](https://img.shields.io/docker/pulls/cheyilin/docker-awscli)](https://hub.docker.com/r/cheyilin/docker-awscli)

```text
cheyilin/docker-awscli:<version-tag>
```

## Examples

### Start a Docker daemon `dockerd`

```bash
$ docker network create dind
$ docker run --privileged --rm --name=dockerd --network=dind --network-alias=docker -e DOCKER_TLS_CERTDIR= docker:20.10-dind
```

### Connect to `dockerd` from `docker-awscli`

```bash
$ docker run -ti --rm --network=dind ghcr.io/cheyilin/docker-awscli:2.2.18

user@docker-awscli:/$ aws --version
aws-cli/2.2.18 Python/3.8.8 Linux/5.10.25-linuxkit exe/aarch64.debian.10 prompt/off

user@docker-awscli:/$ docker version
Client: Docker Engine - Community
 Version:           20.10.7
 API version:       1.41
 Go version:        go1.13.15
 Git commit:        f0df350
 Built:             Wed Jun  2 11:57:26 2021
 OS/Arch:           linux/arm64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.7
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.13.15
  Git commit:       b0f5bc3
  Built:            Wed Jun  2 11:57:00 2021
  OS/Arch:          linux/arm64
  Experimental:     false
 containerd:
  Version:          v1.4.6
  GitCommit:        d71fcd7d8303cbf684402823e425e9dd2e99285d
 runc:
  Version:          1.0.0-rc95
  GitCommit:        b9ee9c6314599f1b4a7f497e1f1f856fe433d3b7
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

### Login and pull/push AWS ECR image within `docker-awscli`

[Using Amazon ECR with the AWS CLI](https://docs.aws.amazon.com/AmazonECR/latest/userguide/getting-started-cli.html)

```bash
user@docker-awscli:/$ aws ecr get-login-password --region AWS_REGION | docker login --username AWS --password-stdin AWS_ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com
user@docker-awscli:/$ docker pull AWS_ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/hello-world:latest
user@docker-awscli:/$ docker push AWS_ACCOUNT_ID.dkr.ecr.AWS_REGION.amazonaws.com/hello-world:latest
```
