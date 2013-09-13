#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for count callback to 0.05s (50ms)
# note: the count callback is only called every second if the
#       count has changed since the last call!
tinkerforge call rotary-encoder-bricklet $uid set-count-callback-period 50

# handle incoming count callbacks
tinkerforge dispatch rotary-encoder-bricklet $uid count
