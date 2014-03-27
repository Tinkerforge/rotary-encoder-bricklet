function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletRotaryEncoder;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kHn'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    encoder = BrickletRotaryEncoder(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for count callback to 0.05s (50ms)
    % Note: The count callback is only called every 50ms if the 
    %       count has changed since the last call!
    encoder.setCountCallbackPeriod(50);

    % Register count callback to function cb_count
    set(encoder, 'CountCallback', @(h, e)cb_count(e.count));

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback function for count callback
function cb_count(count)
    fprintf('Count: %g\n', count);
end
