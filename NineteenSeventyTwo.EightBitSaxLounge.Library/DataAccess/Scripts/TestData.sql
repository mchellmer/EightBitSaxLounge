-- Setup simple loop with only a Ventris Dual Reverb pedal via stored procedure
EXEC spEffectsLoops_CreateEffectsLoop 'VentrisDualReverb', 'A loop having only the Ventris Dual Reverb pedal active.';
EXEC spMusicDevices_CreateMusicDevice 'VentrisDualReverb', 'A dual engine reverb pedal.';
EXEC spEffectsLoops_AddMusicDeviceToEffectsLoop 'VentrisDualReverb', 'VentrisDualReverb';

-- Add necessary effects details for a single reverb engine set to mode 'Room' and associated settings
DECLARE @DummyEffectDetailID INT;
EXEC spEffectDetails_CreateEffectDetail 'ReverbEngineA', 'One of two reverb engines available on the Ventris Dual Reverb.', @DummyEffectDetailID OUTPUT;
EXEC spEffectDetails_CreateEffectDetail 'PreDelayFeedbackHighCut', 'Sets the pre-delay feedback high cutoff frequency.', @DummyEffectDetailID OUTPUT;
EXEC spEffectDetails_CreateEffectDetail 'Time', 'Sets min and max delay times', @DummyEffectDetailID OUTPUT;

-- Add necessary type details for the MidiCcValueType table
EXEC spMidiCcValueTypes_CreateMidiCcValueType 'selector', 'The effect parameter value has several unrelated options - e.g. reverb type.';
EXEC spMidiCcValueTypes_CreateMidiCcValueType 'level', 'The effect parameter value is a level within a min/max range for a single effect - e.g. volume.';

-- Add MidiEffects with CC config values for effect 'ReverbEngineA,' and effect setting effects 'Control1', and 'Time' both set to default values
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'ReverbEngineA', 'One of two reverb engines available on the Ventris Dual Reverb.', 'selector', 0, 1, 0, 13;
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'Control1', 'Custom control 1 particular to reverb mode.', 'level', 0, 15, 0, 127;
EXEC spMidiEffects_CreateMidiEffect 'VentrisDualReverb', 'Time', 'Sets min and max delay times', 'level', 0, 2, 0, 127;

-- Link ReverbEngineA to the Room effect mode, which has a selector CC value of 0
EXEC spMidiEffectModes_CreateMidiEffectMode 'VentrisDualReverb', 'ReverbEngineA', 'Room', 'A reverb effect that simulates playing in a standard room-sized space.', 0;

-- The
EXEC spMidiEffectSettings_CreateMidiEffectSetting 'VentrisDualReverb', 'ReverbEngineA', 'Time';
EXEC spMidiEffectSettings_CreateMidiEffectSetting 'VentrisDualReverb', 'ReverbEngineA', 'Control1';

-- For the VentrisDualReverb ReverbEngineA effect mode 'Room', the 'Control1' setting effect adjusts the pre-delay feedback high cutoff frequency
EXEC spMidiEffectModeSettingDetails_CreateMidiEffectModeSettingDetails 'VentrisDualReverb', 'ReverbEngineA', 'Room', 'Control1', 'PreDelayFeedbackHighCut', 'Sets the pre-delay feedback high cutoff frequency.';