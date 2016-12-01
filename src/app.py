from sense_hat import SenseHat

sense = SenseHat()
sense.clear()
humidity = sense.get_humidity()
print("Humidity: %s %%rH" % humidity)

# alternatives
print(sense.humidity)
