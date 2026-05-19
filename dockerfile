FROM nasafprime/fprime-arm:latest
USER root
RUN sudo pip install -U -r https://raw.githubusercontent.com/nasa/fprime/refs/tags/v4.2.2/requirements.txt

#  ── Bake in pigpio (cross-compiled for ARM) ───────────────────────────────
# Clone pigpio and cross-compile it against aarch64 (or arm-hf for 32-bit)
RUN apt-get update && apt-get install -y git cmake make && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/joan2937/pigpio.git /opt/pigpio-src

RUN cmake \
      -S /opt/pigpio-src \
      -B /opt/pigpio-build \
      -DCMAKE_SYSTEM_NAME=Linux \
      -DCMAKE_C_COMPILER=/opt/toolchains/bin/aarch64-none-linux-gnu-gcc \
      -DCMAKE_CXX_COMPILER=/opt/toolchains/bin/aarch64-none-linux-gnu-g++ \
      -DCMAKE_INSTALL_PREFIX=/opt/pigpio \
      -DBUILD_SHARED_LIBS=OFF \
    && cmake --build /opt/pigpio-build \
    && cmake --install /opt/pigpio-build

# Expose the install path so CMake can find it during fprime cross-compile
ENV PIGPIO_ROOT=/opt/pigpio