FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
USER vscode
ENV PATH="/home/vscode/.elan/bin:${PATH}"
RUN curl --fail --show-error --silent --location https://elan.lean-lang.org/elan-init.sh -o /tmp/elan-init.sh \
    && sh /tmp/elan-init.sh -y --default-toolchain none \
    && rm /tmp/elan-init.sh
