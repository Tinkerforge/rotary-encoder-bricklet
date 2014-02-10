#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletRotaryEncoder;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $encoder = Tinkerforge::BrickletRotaryEncoder->new(&UID, $ipcon); # Create device object

# Callback function for count callback
sub cb_count
{
    my ($count) = @_;
    print "\nCount: $count\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for count callback to 0.05s (50ms)
# Note: The count callback is only called every 50ms if the 
#       count has changed since the last call!
$encoder->set_count_callback_period(50);

# Register count callback to function cb_count
$encoder->register_callback($encoder->CALLBACK_COUNT, 'cb_count');

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

