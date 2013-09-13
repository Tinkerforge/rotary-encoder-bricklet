#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_rotary_encoder import RotaryEncoder

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    encoder = RotaryEncoder(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current count of encoder without reset 
    count = encoder.get_count(False)

    print('Count: ' + str(count))

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
