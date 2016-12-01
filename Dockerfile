FROM resin/raspberrypi3-alpine:edge-20161129

WORKDIR /usr/src/app
ENV INITSYSTEM on


RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
      build-base=0.4-r1 \
      py-sensehat=2.1.0-r0 \
      py2-pip=9.0.0-r0 \
      python2-dev=2.7.12-r7 \
      py2-cffi=1.8.3-r0 \
      libressl-dev=2.4.4-r0 \
      py-numpy=1.11.2-r0 \
      i2c-tools=3.1.2-r2

#      openssl-dev=1.0.2j-r2 \

ENV RTIMUVERSION V7.2.1
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
      git \
      cmake \
      qt-dev=4.8.7-r2 && \
    git clone https://github.com/RPi-Distro/RTIMULib.git && \
    cd RTIMULib && \
    git checkout -b ${RTIMUVERSION} && \
    cd Linux && \
    mkdir build && \
    cd build && \
    cmake .. && \
    build && \
    make install && \
    ldconfig && \
    apk del git cmake qt-dev

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
