function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Rotary Encoder Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    re = java_new("com.tinkerforge.BrickletRotaryEncoder", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register count callback to function cb_count
    re.addCountCallback(@cb_count);

    % Set period for count callback to 0.05s (50ms)
    % Note: The count callback is only called every 0.05 seconds
    %       if the count has changed since the last call!
    re.setCountCallbackPeriod(50);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for count callback
function cb_count(e)
    fprintf("Count: %d\n", e.count);
end
