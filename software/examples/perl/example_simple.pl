#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletRotaryEncoder;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => '7xwQ9g'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $encoder = Tinkerforge::BrickletRotaryEncoder->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current count of encoder without reset 
my $count = $encoder->get_count(0);

print "Count: $count";

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

