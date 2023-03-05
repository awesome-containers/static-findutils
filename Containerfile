# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15
ARG STATIC_BASH_IMAGE=ghcr.io/awesome-containers/static-bash

# https://github.com/awesome-containers/alpine-build-essential
ARG BUILD_ESSENTIAL_VERSION=3.17
ARG BUILD_ESSENTIAL_IMAGE=ghcr.io/awesome-containers/alpine-build-essential


FROM $STATIC_BASH_IMAGE:$STATIC_BASH_VERSION AS static-bash
FROM $BUILD_ESSENTIAL_IMAGE:$BUILD_ESSENTIAL_VERSION AS build

# https://ftp.gnu.org/gnu/findutils/
ARG FINDUTILS_VERSION=4.9.0

WORKDIR /src/findutils
RUN set -xeu; \
    curl -#Lo findutils.tar.gz \
        "https://ftp.gnu.org/gnu/findutils/findutils-$FINDUTILS_VERSION.tar.xz"; \
    tar -xvf findutils.tar.gz --strip-components=1; \
    rm -f findutils.tar.gz

ARG CFLAGS='-w -g -Os -static'
RUN set -xeu; \
    ./configure; \
    make -j"$(nproc)"; \
    mkdir bin; \
    cp find/find locate/locate locate/updatedb xargs/xargs bin/;\
    strip -s -R .comment --strip-unneeded bin/find bin/locate bin/xargs; \
    chmod -cR 755 bin/*; \
    chown -cR 0:0 bin/*; \
    ! ldd bin/find && :; \
    ! ldd bin/locate && :; \
    ! ldd bin/xargs && :; \
    ./bin/find . --version

# static findutils image
FROM static-bash
COPY --from=build /src/findutils/bin/ /bin/
