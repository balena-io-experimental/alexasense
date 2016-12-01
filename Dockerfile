FROM resin/raspberrypi3-debian:jessie-20161130

WORKDIR /usr/src/app
ENV INITSYSTEM on

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      build-essential=11.7 \
      python-dev=2.7.9-1 \
      python-yaml=3.11-2 \
      python-pip=1.5.6-5 \
      sense-hat=1.2 \
      raspberrypi-bootloader=1.20161125-1 \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
