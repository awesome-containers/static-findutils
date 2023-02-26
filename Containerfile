# https://github.com/awesome-containers/static-bash
ARG STATIC_BASH_VERSION=5.2.15

FROM ghcr.io/awesome-containers/alpine-build-essential:3.17 AS build

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
    chmod -cR 755 bin/*; \
    chown -cR 0:0 bin/*; \
    ! ldd bin/find && :; \
    ! ldd bin/locate && :; \
    ! ldd bin/updatedb && :; \
    ! ldd bin/xargs && :; \
    ./bin/find . --version

# static Curl image
FROM ghcr.io/awesome-containers/static-bash:$STATIC_BASH_VERSION
COPY --from=build /src/findutils/bin/ /bin/
