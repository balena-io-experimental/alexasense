FROM resin/raspberrypi3-alpine-python:3.5.2-edge-20161201

WORKDIR /usr/src/app
ENV INITSYSTEM on

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/ ./

CMD ["python", "app.py"]
