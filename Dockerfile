FROM resin/raspberrypi3-python:3.5-20161126

WORKDIR /usr/src/app
ENV INITSYSTEM on

COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY src/* ./

CMD ["python", "app.py"]
