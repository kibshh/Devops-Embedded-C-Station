FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive TZ=UTC
WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-arm-none-eabi binutils-arm-none-eabi \
    gcc-avr binutils-avr avr-libc \
    cmake git python3 python3-pip \
    cppcheck clang-tidy clang-format \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
