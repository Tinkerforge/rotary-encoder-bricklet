#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_rotary_encoder'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
re = BrickletRotaryEncoder.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Set period for count callback to 0.05s (50ms)
# Note: The count callback is only called every 0.05 seconds
#       if the count has changed since the last call!
re.set_count_callback_period 50

# Register count callback
re.register_callback(BrickletRotaryEncoder::CALLBACK_COUNT) do |count|
  puts "Count: #{count}"
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
