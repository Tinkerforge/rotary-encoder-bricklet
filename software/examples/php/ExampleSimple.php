<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletRotaryEncoder.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletRotaryEncoder;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$encoder = new BrickletRotaryEncoder($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get current count of encoder without reset 
$count = $encoder->getCount(false);

echo "Count: $count\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
