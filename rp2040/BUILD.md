# Build

## Manual Build

Get the Raspberry Pi Pico SDK version 2.1.1 and compiler:

```sh
sudo apt install cmake gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib
git clone https://github.com/raspberrypi/pico-sdk
export PICO_SDK_PATH=/path/to/pico-sdk
cd $PICO_SDK_PATH
git submodule update --init
```

Update to the latest TinyUSB release 0.18.0 and apply the dual USB patch:
```sh
cd $PICO_SDK_PATH/lib/tinyusb
patch -p1 < /path/to/itxllama/rp2040/tinyusb-0.18.0-dualusb.patch
```

Generate the UF2 file:
```sh
cd /path/to/itxllama/rp2040
git submodule update --init
cd build
cmake ..
make
```

## Docker Build

Another way to build the firmware is using Docker, which handles all dependencies automatically:

```sh
cd /path/to/itxllama/rp2040
./docker-build.sh
```

The UF2 file will be generated at `build/itxllama-rp2040.uf2`.