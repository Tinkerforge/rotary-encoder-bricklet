<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletRotaryEncoder.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletRotaryEncoder;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

# Callback function for count callback 
function cb_count($count)
{
    echo "Count: $count\n";
}

$ipcon = new IPConnection(); // Create IP connection
$encoder = new BrickletRotaryEncoder(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for count callback to 0.05s (50ms)
// Note: The count callback is only called every 50ms if the 
//       count has changed since the last call!
$encoder->setCountCallbackPeriod(50);

# Register count callback to function cb_count
$encoder->registerCallback(BrickletRotaryEncoder::CALLBACK_COUNT, 'cb_count');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
