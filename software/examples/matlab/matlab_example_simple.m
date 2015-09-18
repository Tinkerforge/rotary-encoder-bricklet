function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletRotaryEncoder;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    re = BrickletRotaryEncoder(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current count without reset
    count = re.getCount(false);
    fprintf('Count: %i\n', count);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
