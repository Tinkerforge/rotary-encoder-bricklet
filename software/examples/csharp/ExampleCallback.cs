using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for count callback 
	static void CountCB(BrickletRotaryEncoder sender, int count)
	{
		System.Console.WriteLine("Count: " + count);
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletRotaryEncoder encoder = new BrickletRotaryEncoder(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set Period for count callback to 0.05s (50ms)
		// Note: The count callback is only called every 50ms if the
		//       count has changed since the last call!
		encoder.SetCountCallbackPeriod(50);

		// Register count callback to function CountCB
		encoder.Count += CountCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
