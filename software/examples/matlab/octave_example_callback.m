function octave_example_callback
    more off;
    
    HOST = "localhost";
    PORT = 4223;
    UID = "kHn"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    encoder = java_new("com.tinkerforge.BrickletRotaryEncoder", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for count callback to 0.05s (50ms)
    % Note: The count callback is only called every 50ms if the 
    %       count has changed since the last call!
    encoder.setCountCallbackPeriod(50);

    % Register count callback to function cb_count
    encoder.addCountCallback(@cb_count);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback function for count callback
function cb_count(e)
    fprintf("Count: %g\n", e.count);
end
