FROM buildpack-deps:bullseye-curl AS distroless

# Debian rootfs download
ARG BULLSEYE_ROOTFS="https://github.com/debuerreotype/docker-debian-artifacts/raw/dist-amd64/bullseye/slim/rootfs.tar.xz"
# ARG BOOKWORM_ROOTFS="https://github.com/debuerreotype/docker-debian-artifacts/raw/dist-amd64/bookworm/slim/rootfs.tar.xz"

WORKDIR /debianroot
RUN apt-get update && apt-get install -y xz-utils
# download and extract debian rootfs into workdir
RUN curl -SL ${BULLSEYE_ROOTFS} -o rootfs.tar.xz
# extract only the minimum that is necessary to execute JRE
RUN tar xvf rootfs.tar.xz usr/lib/locale lib/x86_64-linux-gnu lib64 etc/os-release etc/ld.so.conf.d etc/debian_version usr/lib/x86_64-linux-gnu usr/lib/os-release --same-owner
# remove downloaded archive
RUN rm rootfs.tar.xz

FROM scratch
# copy debian rootfs parts
COPY --from=distroless /debianroot /
