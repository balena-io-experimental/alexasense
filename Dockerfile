FROM resin/raspberrypi3-python:3.5-20161126

WORKDIR /usr/src/app
ENV INITSYSTEM on

RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
      sense-hat=2.2.0-1 \
      raspberrypi-bootloader=1.20161125-1 \
    && apt-get clean

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
