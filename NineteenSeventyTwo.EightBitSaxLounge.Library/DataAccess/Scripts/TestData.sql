-- Insert test values into EffectsLoops
INSERT INTO EffectsLoops (ID, Name, Description)
VALUES (1, 'VentrisDualReverb', 'The loop for the Ventris Dual Reverb');

-- Insert test values into MidiMusicDevices
INSERT INTO MidiMusicDevices (ID, Name, Description)
VALUES (1, 'VentrisDualReverb', 'A dual engine reverb pedal');

-- Insert test values into EffectsLoopMidiDevices
INSERT INTO EffectsLoopMidiDevices (ID, EffectsLoopID, MidiMusicDeviceID)
VALUES (1, 1, 1);

-- Insert test values into EffectDetails
INSERT INTO EffectDetails (ID, Name, Description)
VALUES 
(1, 'EngineA', 'One of two reverb engines available on the Ventris Dual Reverb.'),
(2, 'Room', 'A reverb effect that simulates a playing in a standard room-sized space.'),
(3, 'PreDelayFeedbackHighCut', 'Sets the pre-delay feedback high cutoff frequency.');

-- Insert test values into ParameterTypes
INSERT INTO ParameterTypes (ID, Name, Description)
VALUES (1, 'selector', 'The effect parameter value has several unrelated options - e.g. reverb type.'),
       (2, 'level', 'The effect parameter value is a level within a min/max range for a single effect - e.g. volume.');

-- Insert test values into Effects - enables setting EngineA to Room via the app
INSERT INTO Effects (ID, MidiMusicDeviceId, EffectsDetailsID, CcChannel, CcNumber, CcValueMin, CcValueMax, CcValue, ParameterType)
VALUES (1, 1, 1, 1, 1, 0, 13, 0, 1),
       (2, 1, 3, 1, 15, 0, 127, 0, 2);

-- Insert test values into EffectSelections - links EngineA CcValue 0 sets the reverb effect to Room
INSERT INTO EffectSelections (ID, ReverbEngineEffectID, EffectDetailsID, SelectorCcValue)
VALUES (1, 1, 2, 0);

-- Insert test values into EngineParameters - links Engine Parameter 1 to Engine A
INSERT INTO EngineParameters (ID, ReverbEngineEffectID, EngineParameterEffectID)
VALUES (1, 1, 2);