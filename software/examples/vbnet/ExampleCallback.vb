Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    ' Callback function for count callback
    Sub CountCB(ByVal sender As BrickletRotaryEncoder, ByVal count As Integer)
        System.Console.WriteLine("Count: " + count.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim encoder As New BrickletRotaryEncoder(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Set Period for count callback to 0.05s (50ms)
        ' Note: The count callback is only called every 50ms if the
        '       count has changed since the last call!
        encoder.SetCountCallbackPeriod(50)

        ' Register count callback to CountCB
        AddHandler encoder.Count, AddressOf CountCB

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadKey()
        ipcon.Disconnect()
    End Sub
End Module
