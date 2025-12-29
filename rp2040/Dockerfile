FROM debian:stable-slim

ARG PICO_SDK_VERSION=2.1.1
ARG TINYUSB_VERSION=0.18.0
ARG USER_ID=1000
ARG GROUP_ID=1000

LABEL maintainer="ITX-Llama project"
LABEL description="Build environment for ITX-Llama RP2040 firmware"
LABEL pico-sdk-version="${PICO_SDK_VERSION}"
LABEL tinyusb-version="${TINYUSB_VERSION}"

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
    ca-certificates \
    cmake \
    gcc-arm-none-eabi \
    libnewlib-arm-none-eabi \
    libstdc++-arm-none-eabi-newlib \
    build-essential \
    pkg-config \
    libusb-1.0-0-dev \
    libusb-1.0-0 \
    git \
    python3 \
    patch \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone

WORKDIR /opt
RUN git clone --depth 1 --branch ${PICO_SDK_VERSION} \
    https://github.com/raspberrypi/pico-sdk

WORKDIR /opt/pico-sdk
RUN git submodule update --init

COPY tinyusb-0.18.0-dualusb.patch /tmp/dualusb.patch
WORKDIR /opt/pico-sdk/lib/tinyusb
RUN git checkout ${TINYUSB_VERSION} && \
    patch -p1 < /tmp/dualusb.patch && \
    rm /tmp/dualusb.patch

ENV PICO_SDK_PATH=/opt/pico-sdk

RUN groupadd -g ${GROUP_ID} builder 2>/dev/null || true && \
    useradd -l -m -u ${USER_ID} -g ${GROUP_ID} builder \
    2>/dev/null || true

USER builder
WORKDIR /work

CMD ["bash"]
