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

    % Get current count of encoder without reset 
    count = encoder.getCount(false);

    fprintf('Count: %g\n', count);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

