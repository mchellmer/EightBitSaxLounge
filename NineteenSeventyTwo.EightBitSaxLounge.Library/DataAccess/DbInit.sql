-- Drop existing tables in the correct order
IF OBJECT_ID('EngineParameters', 'U') IS NOT NULL DROP TABLE EngineParameters;
IF OBJECT_ID('EffectsLoopMidiDevices', 'U') IS NOT NULL DROP TABLE EffectsLoopMidiDevices;
IF OBJECT_ID('Effects', 'U') IS NOT NULL DROP TABLE Effects;
IF OBJECT_ID('EffectDetails', 'U') IS NOT NULL DROP TABLE EffectDetails;
IF OBJECT_ID('ParameterTypes', 'U') IS NOT NULL DROP TABLE ParameterTypes;
IF OBJECT_ID('MidiMusicDevices', 'U') IS NOT NULL DROP TABLE MidiMusicDevices;
IF OBJECT_ID('EffectsLoops', 'U') IS NOT NULL DROP TABLE EffectsLoops;
GO

-- Create new tables
CREATE TABLE EffectsLoops (
                              ID INT PRIMARY KEY,
                              Name VARCHAR(255) NOT NULL,
                              Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE MidiMusicDevices (
                                  ID INT PRIMARY KEY,
                                  Name VARCHAR(255) NOT NULL,
                                  Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE EffectsLoopMidiDevices (
                                        ID INT PRIMARY KEY,
                                        EffectsLoopID INT NOT NULL,
                                        MidiMusicDeviceID INT NOT NULL,
                                        FOREIGN KEY (EffectsLoopID) REFERENCES EffectsLoops(ID),
                                        FOREIGN KEY (MidiMusicDeviceID) REFERENCES MidiMusicDevices(ID)
);
GO

CREATE TABLE EffectDetails (
                               ID INT PRIMARY KEY,
                               Name VARCHAR(255) NOT NULL,
                               Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE ParameterTypes (
                                ID INT PRIMARY KEY,
                                Name VARCHAR(255) NOT NULL,
                                Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE Effects (
                         ID INT PRIMARY KEY,
                         MidiMusicDeviceId INT NOT NULL,
                         EffectsDetailsID INT NOT NULL,
                         CcChannel INT NOT NULL,
                         CcNumber INT NOT NULL,
                         CcValueMin INT NOT NULL,
                         CcValueMax INT NOT NULL,
                         CcValue INT NOT NULL,
                         ParameterType INT NOT NULL,
                         FOREIGN KEY (MidiMusicDeviceId) REFERENCES MidiMusicDevices(ID),
                         FOREIGN KEY (EffectsDetailsID) REFERENCES EffectDetails(ID),
                         FOREIGN KEY (ParameterType) REFERENCES ParameterTypes(ID)
);
GO

CREATE TABLE EngineParameters (
                                  ID INT PRIMARY KEY,
                                  ReverbEngineEffectID INT NOT NULL,
                                  EngineParameterEffectID INT NOT NULL,
                                  FOREIGN KEY (ReverbEngineEffectID) REFERENCES Effects(ID),
                                  FOREIGN KEY (EngineParameterEffectID) REFERENCES Effects(ID)
);
GO