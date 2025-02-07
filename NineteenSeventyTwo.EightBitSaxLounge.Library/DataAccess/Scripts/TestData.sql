-- Setup simple loop with only a Ventris Dual Reverb pedal via stored procedure
EXEC spEffectsLoops_CreateEffectsLoop 'VentrisDualReverb', 'A loop having only the Ventris Dual Reverb pedal active.';
EXEC spMusicDevices_CreateMusicDevice 'VentrisDualReverb', 'A dual engine reverb pedal.';
EXEC spEffectsLoops_AddMusicDeviceToEffectsLoop 'VentrisDualReverb', 'VentrisDualReverb';

-- Add necessary effects details for a single reverb engine set to mode 'Room' and associated settings
EXEC spEffectDetails_CreateEffectDetail 'ReverbEngineA', 'One of two reverb engines available on the Ventris Dual Reverb.';
EXEC spEffectDetails_CreateEffectDetail 'Room', 'A reverb effect that simulates playing in a standard room-sized space.';
EXEC spEffectDetails_CreateEffectDetail 'PreDelayFeedbackHighCut', 'Sets the pre-delay feedback high cutoff frequency.';
EXEC spEffectDetails_CreateEffectDetail 'Time', 'Sets min and max delay times';

-- Add necessary type details for the MidiCcValueType table
EXEC spMidiCcValueTypes_CreateMidiCcValueType 'selector', 'The effect parameter value has several unrelated options - e.g. reverb type.';
EXEC spMidiCcValueTypes_CreateMidiCcValueType 'level', 'The effect parameter value is a level within a min/max range for a single effect - e.g. volume.';

-- Add MidiEffects with CC config values for effect 'ReverbEngineA,' and effect setting effects 'Control1', and 'Time' both set to default values
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'ReverbEngineA', 'One of two reverb engines available on the Ventris Dual Reverb.', 'selector', 0, 1, 0, 13;
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'Control1', 'Custom control 1 particular to reverb mode.', 'level', 0, 15, 0, 127;
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'Time', 'Sets min and max delay times', 'level', 0, 2, 0, 127;

-- Link ReverbEngineA to the Room effect mode, which has a selector CC value of 0
INSERT INTO MidiEffectModes (MidiEffectID, EffectDetailsID, SelectorCcValue)
VALUES (1, 2, 0);

-- Link ReverbEngineA effect to its setting effects 'Time' and 'Control1'
INSERT INTO MidiEffectSettings (MidiEffectID, MidiEffectSettingEffectID)
VALUES (1, 2),
       (1, 3);

-- Link Effect Setting details for the 'Room' effect setting to the 'PreDelayFeedbackHighCut' effect detail
INSERT INTO MidiEffectSettingSettingss (MidiSettingEffectID, EffectDetailsID)
VALUES (1, 2);