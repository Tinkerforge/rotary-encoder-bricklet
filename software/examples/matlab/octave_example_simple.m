function octave_example_simple()
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "kHn"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    encoder = java_new("com.tinkerforge.BrickletRotaryEncoder", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current count of encoder without reset 
    count = encoder.getCount(false);
    fprintf("Count: %g\n", count);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end
