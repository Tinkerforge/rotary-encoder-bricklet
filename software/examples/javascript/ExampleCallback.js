var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'utz'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var encoder = new Tinkerforge.BrickletRotaryEncoder(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for count callback to 0.05s (50ms)
        // Note: The count callback is only called every 50ms if the
        // count has changed since the last call!
        encoder.setCountCallbackPeriod(50);
    }
);

// Register count callback
encoder.on(Tinkerforge.BrickletRotaryEncoder.CALLBACK_COUNT,
    // Callback function for count callback
    function(count) {
        console.log('Count: '+count);
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
