FROM resin/raspberrypi3-alpine:edge-20161129

WORKDIR /usr/src/app
ENV INITSYSTEM on


RUN apk add --no-cache \
      build-base=0.4-r1 \
      py-sensehat=2.1.0-r0 \
      py2-pip=9.0.0-r0 \
      python2-dev=2.7.12-r7 \
      py2-cffi=1.8.3-r0

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
