#!/bin/bash
set -e

PICO_SDK_VERSION=${PICO_SDK_VERSION:-2.1.1}
TINYUSB_VERSION=${TINYUSB_VERSION:-0.18.0}

echo "Initialising Git submodules..."
git submodule update --init

echo "Building Docker image..."

docker build \
  --build-arg PICO_SDK_VERSION="${PICO_SDK_VERSION}" \
  --build-arg TINYUSB_VERSION="${TINYUSB_VERSION}" \
  --build-arg USER_ID="$(id -u)" \
  --build-arg GROUP_ID="$(id -g)" \
  -t itxllama-rp2040-builder .

echo "Building ITX-Llama RP2040 firmware..."

docker run --rm -v "$(pwd):/work" itxllama-rp2040-builder bash -c "
    rm -rf build && \
    mkdir -p build && \
    cd build && \
    cmake .. && \
    make
"

file build/itxllama-rp2040.uf2

echo "Done."
