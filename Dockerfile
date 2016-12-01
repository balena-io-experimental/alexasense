FROM resin/raspberrypi3-debian:jessie-20161130

WORKDIR /usr/src/app
ENV INITSYSTEM on

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      python3=3.4.2-2 \
      sense-hat=1.2 \
      raspberrypi-bootloader=1.20161125-1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Build extra library requirements
COPY requirements.txt ./
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      build-essential libyaml-dev python3-dev python3-pip && \
    pip3 install -r requirements.txt && \
    apt-get remove \
      build-essential libyaml-dev python3-dev python3-pip && \
      apt-get clean && rm -rf /var/lib/apt/lists/*

COPY start.sh ./
COPY src/* ./

CMD ["bash", "start.sh"]
