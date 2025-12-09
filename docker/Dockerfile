# Embedded C DevOps Development Environment
# This Dockerfile creates an isolated environment for embedded C development

# Use Ubuntu as base image (stable and well-supported)
FROM ubuntu:22.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Set working directory inside container
WORKDIR /workspace

# Install essential build tools and embedded C toolchains
# Explanation of each package:
# - build-essential: GCC compiler, make, and other essential build tools
# - gcc-arm-none-eabi: ARM cross-compiler for embedded systems (very common)
# - gcc-avr: AVR cross-compiler for Atmel/Microchip AVR microcontrollers
# - cmake: Modern build system generator
# - git: Version control
# - vim: Text editor (you can add others if needed)
# - python3: Often needed for build scripts and testing tools
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc-arm-none-eabi \
    binutils-arm-none-eabi \
    gcc-avr \
    binutils-avr \
    avr-libc \
    cmake \
    git \
    vim \
    python3 \
    python3-pip \
    cppcheck \
    clang-tidy \
    clang-format \
    && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN arm-none-eabi-gcc --version && \
    avr-gcc --version && \
    gcc --version && \
    cmake --version && \
    cppcheck --version && \
    clang-tidy --version && \
    clang-format --version

# Set default command to bash shell
CMD ["/bin/bash"]

