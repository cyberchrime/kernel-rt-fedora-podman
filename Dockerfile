ARG ARCH
ARG FEDORA_VERSION
FROM docker.io/${ARCH}/fedora:${FEDORA_VERSION}

# Install build requirements
RUN dnf update -y && \
    dnf install -y \
	fedpkg \
	wget \
	xz \
	git  \
        bc \
        bison \
        bpftool \
        dracut \
        dwarves \
        elfutils \
        flex \
        gcc \
        glibc \
        hostname \
        libkcapi-hmaccalc \
        lvm2 \
        m4 \
        make \
        nss \
        openssl \
        perl-devel \
        perl-generators \
        pesign \
        python3 \
        systemd \
        tpm2-tools \
        elfutils-devel \
        gcc-c++ \
        glibc-static \
        kernel-rpm-macros \
        net-tools \
        openssl-devel \
        python3-devel \
        which && \
    dnf clean all


# Add entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /root
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
