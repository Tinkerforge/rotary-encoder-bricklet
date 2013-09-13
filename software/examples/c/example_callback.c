
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_rotary_encoder.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for count callback
void cb_count(int32_t count, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Count: %d\n", count);
}

int main() {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	RotaryEncoder encoder;
	rotary_encoder_create(&encoder, UID, &ipcon); 

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		exit(1);
	}
	// Don't use device before ipcon is connected

	// Set Period for count callback to 0.05s (50ms)
	// Note: The count callback is only called every 50ms if the 
	//       count has changed since the last call!
	rotary_encoder_set_count_callback_period(&encoder, 50);

	// Register count callback to function cb_count
	rotary_encoder_register_callback(&encoder,
	                                 ROTARY_ENCODER_CALLBACK_COUNT,
	                                 (void *)cb_count,
	                                 NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
}
