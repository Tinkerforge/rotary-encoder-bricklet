#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_rotary_encoder'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Rotary Encoder Bricklet

ipcon = IPConnection.new # Create IP connection
re = BrickletRotaryEncoder.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current count without reset
count = re.get_count false
puts "Count: #{count}"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
