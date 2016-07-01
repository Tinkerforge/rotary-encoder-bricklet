<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletRotaryEncoder.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletRotaryEncoder;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Rotary Encoder Bricklet

$ipcon = new IPConnection(); // Create IP connection
$re = new BrickletRotaryEncoder(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current count without reset
$count = $re->getCount(FALSE);
echo "Count: $count\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
