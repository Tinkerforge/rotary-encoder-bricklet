using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Rotary Encoder Bricklet

	// Callback function for count callback
	static void CountCB(BrickletRotaryEncoder sender, int count)
	{
		Console.WriteLine("Count: " + count);
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletRotaryEncoder re = new BrickletRotaryEncoder(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register count callback to function CountCB
		re.Count += CountCB;

		// Set period for count callback to 0.05s (50ms)
		// Note: The count callback is only called every 0.05 seconds
		//       if the count has changed since the last call!
		re.SetCountCallbackPeriod(50);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
