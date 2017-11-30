Imports System
Imports Tinkerforge

Module ExampleCallback
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change XYZ to the UID of your Rotary Encoder Bricklet

    ' Callback subroutine for count callback
    Sub CountCB(ByVal sender As BrickletRotaryEncoder, ByVal count As Integer)
        Console.WriteLine("Count: " + count.ToString())
    End Sub

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim re As New BrickletRotaryEncoder(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Register count callback to subroutine CountCB
        AddHandler re.CountCallback, AddressOf CountCB

        ' Set period for count callback to 0.05s (50ms)
        ' Note: The count callback is only called every 0.05 seconds
        '       if the count has changed since the last call!
        re.SetCountCallbackPeriod(50)

        Console.WriteLine("Press key to exit")
        Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
