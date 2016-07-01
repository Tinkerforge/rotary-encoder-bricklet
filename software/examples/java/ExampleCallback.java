import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletRotaryEncoder;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Rotary Encoder Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletRotaryEncoder re = new BrickletRotaryEncoder(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Add count listener
		re.addCountListener(new BrickletRotaryEncoder.CountListener() {
			public void count(int count) {
				System.out.println("Count: " + count);
			}
		});

		// Set period for count callback to 0.05s (50ms)
		// Note: The count callback is only called every 0.05 seconds
		//       if the count has changed since the last call!
		re.setCountCallbackPeriod(50);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
