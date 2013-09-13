#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get current count without reset 
tinkerforge call rotary-encoder-bricklet $uid get-count false
