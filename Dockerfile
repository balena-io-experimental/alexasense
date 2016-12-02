FROM resin/raspberrypi3-debian:jessie-20161130

WORKDIR /usr/src/app
ENV INITSYSTEM on

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      python3=3.4.2-2 \
      sense-hat=1.2 \
      raspberrypi-bootloader=1.20161125-1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# To install vcgencmd
ENV USERLANDVER bb15afe33b313fe045d52277a78653d288e04f67
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      build-essential cmake git \
    && git clone https://github.com/raspberrypi/userland.git && \
    cd userland && \
    git checkout -b build ${USERLANDVER} && \
    bash ./buildme && \
    cd .. && \
    rm -rf userland && \
    apt-get remove \
      build-essential cmake git \
    && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

# Build extra library requirements
COPY requirements.txt ./
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      build-essential libssl-dev libffi-dev libyaml-dev python3-dev python3-pip && \
    pip3 install -r requirements.txt && \
    apt-get remove \
      build-essential libssl-dev libffi-dev libyaml-dev python3-dev python3-pip \
    && apt-get autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY src/* ./
COPY start.sh ./

CMD ["bash", "start.sh"]
