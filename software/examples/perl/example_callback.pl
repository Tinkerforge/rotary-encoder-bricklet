#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletRotaryEncoder;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Rotary Encoder Bricklet

# Callback subroutine for count callback
sub cb_count
{
    my ($count) = @_;

    print "Count: $count\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $re = Tinkerforge::BrickletRotaryEncoder->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Register count callback to subroutine cb_count
$re->register_callback($re->CALLBACK_COUNT, 'cb_count');

# Set period for count callback to 0.05s (50ms)
# Note: The count callback is only called every 0.05 seconds
#       if the count has changed since the last call!
$re->set_count_callback_period(50);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
