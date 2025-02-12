using Microsoft.Extensions.Configuration;

Console.WriteLine("Loading midi device config from json...");

IConfigurationBuilder builder = new ConfigurationBuilder()
    .SetBasePath(AppContext.BaseDirectory)
    .AddJsonFile("appsettings.json");

IConfigurationRoot root = builder.Build();

var effectsLoopsToSeed = root.GetSection("SeedDataEffectsLoops").GetChildren();

foreach (var effectsLoop in effectsLoopsToSeed)
{
    Console.WriteLine($"Effects loop: {effectsLoop["Name"]}. Adding to database.");
    

    var devices = effectsLoop.GetSection("Devices").GetChildren();

    foreach (var device in devices)
    {
        string deviceName = device.Value;
        Console.WriteLine($"Loading configuration for device: {deviceName}");

        IConfigurationBuilder deviceBuilder = new ConfigurationBuilder()
            .SetBasePath(AppContext.BaseDirectory)
            .AddJsonFile($"appsettings.Devices.{deviceName}.json");

        IConfigurationRoot deviceRoot = deviceBuilder.Build();
        var midiEffects = deviceRoot.GetSection("MidiEffects");

        // TODO: settings validation
        foreach (var midiEffect in midiEffects.GetChildren())
        {
            Console.WriteLine($"Effect Name: {midiEffect["Name"]}");
            Console.WriteLine($"Effect Description: {midiEffect["Description"]}");
        }
    }
}

Console.WriteLine("Midi device config loaded.");