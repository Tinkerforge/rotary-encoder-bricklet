function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Rotary Encoder Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    re = javaObject("com.tinkerforge.BrickletRotaryEncoder", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current count without reset
    count = re.getCount(false);
    fprintf("Count: %d\n", count);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end
