from sense_hat import SenseHat
import logging
from flask import Flask, render_template
from flask_ask import Ask, statement, question, session
import os

## Setting up the SenseHAT
sense = SenseHat()
sense.clear()
sense.show_message("Hello Alexa")

## Setting up Alexa
app = Flask(__name__)
ask = Ask(app, "/")
logging.getLogger("flask_ask").setLevel(logging.DEBUG)

## Services
@ask.launch
def get_hello():
    card_title = ('RPi with SenseHAT')
    hello_msg = render_template('hello')
    prompt = render_template('prompt')
    return question(hello_msg).reprompt(prompt).simple_card(card_title, hello_msg)

@ask.intent('QuestionIntent')
def answer_question(target):
    if target == 'temperature':
        get_temperature()
    elif target == 'humidity':
        get_humidity()
    elif target == 'pressure':
        get_pressure()
    else:
        prompt = render_template('prompt')
        return statement(prompt)

@ask.intent('EnvironmentIntent')
def get_environment():
    statement("Come back in a bit")

@ask.intent('TemperatureIntent')
def get_temperature():
    temperature = round(sense.get_temperature(), 1)
    temperature_msg = render_template('temperature', temperature=temperature)
    card_title = 'RPi with SenseHAT'
    temperature_card = render_template('temperature_card', temperature=temperature)
    return statement(temperature_msg).simple_card(card_title, temperature_card)

@ask.intent('HumidityIntent')
def get_humidity():
    humidity = int(sense.get_humidity())
    humidity_msg = render_template('humidity', humidity=humidity)
    card_title = 'RPi with SenseHAT'
    humidity_card = render_template('humidity_card', humidity=humidity)
    return statement(humidity_msg).simple_card(card_title, humidity_card)

@ask.intent('PressureIntent')
def get_pressure():
    pressure = round(sense.get_pressure(), 1)
    pressure_msg = render_template('pressure', pressure=pressure)
    card_title = 'RPi with SenseHAT'
    pressure_card = render_template('pressure_card', pressure=pressure)
    return statement(humidity_msg).simple_card(card_title, pressure_card)

if __name__ == '__main__':
    # Load DEBUG variable from the environment
    debug = True if os.getenv('DEBUG', '0') == '1' else False
    app.run(port=80, debug=debug)
