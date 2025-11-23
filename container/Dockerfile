FROM ubuntu:22.04
LABEL maintainer="jordyaquiteme@gmail.com"

ARG GH_RUNNER_VERSION="2.329.0"
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y curl tar sudo git build-essential libssl-dev libffi-dev \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

WORKDIR /actions-runner

RUN useradd -m gh-runner \
    && chown gh-runner:gh-runner -R /actions-runner

# Download github self-hosted runner code
RUN curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v${GH_RUNNER_VERSION}/actions-runner-linux-x64-${GH_RUNNER_VERSION}.tar.gz \
    && tar --no-same-owner --no-same-permissions --no-xattrs -xzf actions-runner.tar.gz \
    && rm actions-runner.tar.gz

# Install dependencies
RUN chmod +x /actions-runner/bin/installdependencies.sh && /actions-runner/bin/installdependencies.sh

COPY entrypoint.sh /entrypoint.sh

USER gh-runner

ENTRYPOINT ["/entrypoint.sh"]