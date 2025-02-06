-- Setup simple loop with only a Ventris Dual Reverb pedal
INSERT INTO EffectsLoops (ID, Name, Description)
VALUES (1, 'VentrisDualReverb', 'The loop including only a Ventris Dual Reverb pedal.');

INSERT INTO MusicDevices (ID, Name, Description)
VALUES (1, 'VentrisDualReverb', 'A dual engine reverb pedal.');

INSERT INTO EffectsLoopDevices (ID, EffectsLoopID, MusicDeviceID)
VALUES (1, 1, 1);

-- Add necessary effects details for a single reverb engine set to mode 'Room' and associated settings
INSERT INTO EffectDetails (ID, Name, Description)
VALUES 
(1, 'ReverbEngineA', 'One of two reverb engines available on the Ventris Dual Reverb.'),
(2, 'Room', 'A reverb effect that simulates playing in a standard room-sized space.'),
(3, 'PreDelayFeedbackHighCut', 'Sets the pre-delay feedback high cutoff frequency.'),
(4,'Time', 'Sets min and max delay times');

-- Add necessary type details for the MidiCcValueType table
INSERT INTO MidiCcValueTypes (ID, Name, Description)
VALUES (1, 'selector', 'The effect parameter value has several unrelated options - e.g. reverb type.'),
       (2, 'level', 'The effect parameter value is a level within a min/max range for a single effect - e.g. volume.');

-- Add MidiEffects with CC config values for effect 'ReverbEngineA,' and effect setting effects 'Control1', and 'Time' both set to default values
INSERT INTO MidiEffects (ID, MusicDeviceID, EffectsDetailsID, MidiCcValueTypeID, CcChannel, CcNumber, CcValueMin, CcValueMax, CcValue)
VALUES (1, 1, 1, 1, 1, 0, 13, 0, 1),
       (2, 1, 3, 2, 15, 0, 127, 0, 50),
       (3, 1, 4, 2, 2, 0, 127, 0, 50);

-- Link ReverbEngineA to the Room effect mode, which has a selector CC value of 0
INSERT INTO MidiEffectModes (ID, MidiEffectID, EffectDetailsID, SelectorCcValue)
VALUES (1, 1, 2, 0);

-- Link ReverbEngineA effect to its setting effects 'Time' and 'Control1'
INSERT INTO MidiEffectSettings (ID, MidiEffectID, MidiEffectSettingEffectID)
VALUES (1, 1, 2),
       (2, 1, 3);

-- Link Effect Setting details for the 'Room' effect setting to the 'PreDelayFeedbackHighCut' effect detail
INSERT INTO MidiEffectSettingSettingss (ID, MidiSettingEffectID, EffectDetailsID)
VALUES (1, 1, 2);