function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletRotaryEncoder;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change XYZ to the UID of your Rotary Encoder Bricklet

    ipcon = IPConnection(); % Create IP connection
    re = handle(BrickletRotaryEncoder(UID, ipcon), 'CallbackProperties'); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register count callback to function cb_count
    set(re, 'CountCallback', @(h, e) cb_count(e));

    % Set period for count callback to 0.05s (50ms)
    % Note: The count callback is only called every 0.05 seconds
    %       if the count has changed since the last call!
    re.setCountCallbackPeriod(50);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for count callback
function cb_count(e)
    fprintf('Count: %i\n', e.count);
end
