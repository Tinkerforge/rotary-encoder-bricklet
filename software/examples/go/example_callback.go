package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/rotary_encoder_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Rotary Encoder Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	re, _ := rotary_encoder_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	re.RegisterCountCallback(func(count int32) {
		fmt.Printf("Count: %d\n", count)
	})

	// Set period for count receiver to 0.05s (50ms).
	// Note: The count callback is only called every 0.05 seconds
	//       if the count has changed since the last call!
	re.SetCountCallbackPeriod(50)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
