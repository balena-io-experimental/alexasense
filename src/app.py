from sense_hat import SenseHat

print("Starting!")

sense = SenseHat()
sense.clear()
humidity = sense.get_humidity()
print("Humidity: %s %%rH" % humidity)

# alternatives
print(sense.humidity)
