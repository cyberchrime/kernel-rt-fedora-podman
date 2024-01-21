ARG ARCH
ARG FEDORA_VERSION
FROM docker.io/${ARCH}/fedora:${FEDORA_VERSION}

ARG ARCH
ENV ARCH ${ARCH}

# Install build requirements
RUN dnf update -y && \
    dnf install -y \
	wget \
	xz \
	git \
	fedpkg && \
    dnf clean all


# Add entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
