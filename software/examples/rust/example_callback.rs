use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, rotary_encoder_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Rotary Encoder Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let re = RotaryEncoderBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    let count_receiver = re.get_count_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `re` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for count in count_receiver {
            println!("Count: {}", count);
        }
    });

    // Set period for count receiver to 0.05s (50ms).
    // Note: The count callback is only called every 0.05 seconds
    //       if the count has changed since the last call!
    re.set_count_callback_period(50);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
