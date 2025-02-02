# Eight bit sax lounge
## Overview
- Defines a midi music device and associated CRUD service
  - to track configuration e.g. init config and updated config
  - to update configuration via midi message to USB
- Defines an effects loop composed of midi music devices exposed via a minimal REST API
  - to GET the current configuration of the effects loop
    - returns the current configuration of the effects loop from the tracking database
  - to PUT updates to the configuration of the midi music devices
    - updates configuration tracking database
    - sends midi message to USB to update the device
  - to POST new devices to the effects loop configuration
    - adds new device to configuration tracking database
  - to POST additional config to existing devices on the loop
    - e.g. if the scope of the app is expanded to include additional parameters for a device
  - to DELETE devices from the effects loop configuration
    - removes device from configuration tracking database
- Defines a twitch bot that can interact with a Twitch stream
  - to monitor chat for commands
    - a bot user joins the chat via the Twitch API and an OAuth token
  - to respond to commands
    - the Twitch API exposes different types of actions base on e.g. OnMessageReceived, OnCommandReceived, etc.
    - e.g. OnCommandReceived = !engine room - make a put request to the effects loop api to set the reverb engine to 'room'
  - to send commands to the effects loop API
    - e.g. get /api/effectsloop - get the current configuration of the effects loop in order to update OBS overlay or inform the chat of the current configuration
    - e.g. put /api/effectsloop/ventris - update the Ventris dual reverb to a new configuration as defined by body of the request

### Concepts
- midi music device - a device that can be controlled by midi messages
    - e.g. Ventris dual reverb - send CC midi message to set reverb settings via USB
- twitch bot - a user that can interact with a Twitch stream
    - i.e. the bot can monitor chat and respond to commands
    - e.g. !engine room - set the reverb engine to 'room'
- effects loop - the effects loop sits between an instrument and an amplifier, it alters the sound of the instrument before it reaches the amplifier
    - e.g. the Ventris dual reverb adds reverb to amplified music
- effects loop api - an api that can be used to control an effects loop device
    - PUT api/update/ventris - the Ventris dual reverb has a configuration that can be updated via api

### Compatibility
- PC - winmm.dll used to interact with USB devices on Windows
  - PC used initially as Twitch streaming setup is currently hosted on Windows via OBS
  - Ventris settings can be monitored visually via a Windows app provided by the vendor

## Data requirements
### Overview
- At any given time there are several parameters set for a midi music device that can be set via CC#
  - these settings cannot always be retrieved - need to track/set initial values
  - For Ventris these settings can be monitored via a vendor app for validation
  - when powering on a midi music device there is some initial configuration
    - some config can be based on device software
    - some config is based on device hardware e.g. a physical switch is on or off/a dial has a range of values 0-255 etc
- config - a midi music device has a static midi implementation
  - For Ventris e.g. midi CC# 1 always corresponds to Reverb Engine A 
  - For Ventris e.g. midi CC# 1 has a range of values from 0-13
  - Some value ranges simply adjust an effects level e.g. 0-127 less to more reverberation
  - Some value ranges adjust a parameter e.g. 0-13 selects completely different reverb engines from the 14 available
- state - a midi music device has a value set for each CC#
  - For Ventris e.g. set value for CC# 1 to 0 - sets Reverb Engine A to 'room' engine
- data solutions
  - config - appsettings or sql database
  - state - sql database

### Data model
Storage Considerations
- appsettings for config?
  - simple to update via ide/PR
  - can be a large amount of config i.e. large json entries
  - values never change
- sql for config
  - must query/update a live db to view/insert data
  - simplifies and consolidates data access layer to interacting with sql via stored procedures

Models
- EffectsLoops - a group of effects combined into a loop
  - ID
  - Name - e.g. VentrisSingleEngine
  - Description

- MidiMusicDevices - a device configurable via midi that can add a music effect
  - ID
  - Name - e.g. VentrisDualReverbEngineA
  - Description

- EffectsLoopMidiDevices - midi devices in each loop
  - ID
  - EffectsLoopID
  - MidiMusicDeviceID

- ParameterTypes - the type of parameter that can be set for a midi music device
  - ID
  - Name - e.g. Selector, level
  - Description

- Effects - effects details and state as well as the device that can create them
  - ID
  - MidiMusicDeviceId
  - EffectsDetailsID
  - CcChannel
  - CcNumber
  - CcValueMin
  - CcValueMax
  - CcValue
  - ParameterTypeID - e.g. selector vs level

- EffectDetails - some effects are the same across midi devices
  - ID
  - Name
  - Description

- EngineParameters - effects particular to a Reverb Engine e.g. Distortion level for lo-fi engine
  - ID
  - ReverbEffectID - e.g. ID for Lo-Fi effect
  - EffectID - e.g. ID for Distortion effect

## Midi music devices
- the Ventris dual reverb
  - Has several reverb engines and associated parameters allowing complex manipulation of amplified music
  - It can be configured via midi messages to USB