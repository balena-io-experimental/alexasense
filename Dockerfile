FROM resin/raspberrypi3-debian:jessie-20161130

WORKDIR /usr/src/app
ENV INITSYSTEM on

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      python-pip=1.5.6-5 \
      sense-hat=1.2 \
      raspberrypi-bootloader=1.20161125-1 \
    && apt-get clean

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
