#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Handle incoming count callbacks
tinkerforge dispatch rotary-encoder-bricklet $uid count &

# Set period for count callback to 0.05s (50ms)
# Note: The count callback is only called every 0.05 seconds
#       if the count has changed since the last call!
tinkerforge call rotary-encoder-bricklet $uid set-count-callback-period 50

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
