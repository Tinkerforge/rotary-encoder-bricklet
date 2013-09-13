#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_rotary_encoder import RotaryEncoder

# Callback function for count callback
def cb_count(count):
    print('Count: ' + str(count))

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    encoder = RotaryEncoder(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set Period for count callback to 0.05s (50ms)
    # Note: The count callback is only called every 50ms if the 
    #       count has changed since the last call!
    encoder.set_count_callback_period(50)

    # Register count callback to function cb_count
    encoder.register_callback(encoder.CALLBACK_COUNT, cb_count)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
