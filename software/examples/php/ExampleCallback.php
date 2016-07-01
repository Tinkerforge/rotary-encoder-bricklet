<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletRotaryEncoder.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletRotaryEncoder;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Rotary Encoder Bricklet

// Callback function for count callback
function cb_count($count)
{
    echo "Count: $count\n";
}

$ipcon = new IPConnection(); // Create IP connection
$re = new BrickletRotaryEncoder(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register count callback to function cb_count
$re->registerCallback(BrickletRotaryEncoder::CALLBACK_COUNT, 'cb_count');

// Set period for count callback to 0.05s (50ms)
// Note: The count callback is only called every 0.05 seconds
//       if the count has changed since the last call!
$re->setCountCallbackPeriod(50);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
