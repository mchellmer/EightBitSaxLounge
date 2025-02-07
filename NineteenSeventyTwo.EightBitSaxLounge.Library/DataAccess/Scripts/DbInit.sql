-- Drop existing tables in the correct order
IF OBJECT_ID('MidiEffectSettingSettingss', 'U') IS NOT NULL DROP TABLE MidiEffectSettingSettingss;
IF OBJECT_ID('MidiEffectSettings', 'U') IS NOT NULL DROP TABLE MidiEffectSettings;
IF OBJECT_ID('MidiEffectModes', 'U') IS NOT NULL DROP TABLE MidiEffectModes;
IF OBJECT_ID('MidiEffects', 'U') IS NOT NULL DROP TABLE MidiEffects;
IF OBJECT_ID('MidiCcValueTypes', 'U') IS NOT NULL DROP TABLE MidiCcValueTypes;
IF OBJECT_ID('EffectDetails', 'U') IS NOT NULL DROP TABLE EffectDetails;
IF OBJECT_ID('EffectsLoopDevices', 'U') IS NOT NULL DROP TABLE EffectsLoopDevices;
IF OBJECT_ID('MusicDevices', 'U') IS NOT NULL DROP TABLE MusicDevices;
IF OBJECT_ID('EffectsLoops', 'U') IS NOT NULL DROP TABLE EffectsLoops;
GO

-- Create new tables
CREATE TABLE EffectsLoops (
                              ID INT PRIMARY KEY IDENTITY(1,1), -- ensure unique ID, start fron 1, increment by 1
                              Name VARCHAR(255) NOT NULL,
                              Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE MusicDevices (
                                  ID INT PRIMARY KEY IDENTITY(1,1),
                                  Name VARCHAR(255) NOT NULL,
                                  Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE EffectsLoopDevices (
                                        ID INT PRIMARY KEY IDENTITY(1,1),
                                        EffectsLoopID INT NOT NULL,
                                        MusicDeviceID INT,
                                        FOREIGN KEY (EffectsLoopID) REFERENCES EffectsLoops(ID),
                                        FOREIGN KEY (MusicDeviceID) REFERENCES MusicDevices(ID)
);
GO

CREATE TABLE EffectDetails (
                               ID INT PRIMARY KEY IDENTITY(1,1),
                               Name VARCHAR(255) NOT NULL,
                               Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE MidiCcValueTypes (
                                ID INT PRIMARY KEY IDENTITY(1,1),
                                Name VARCHAR(255) NOT NULL,
                                Description VARCHAR(MAX) NOT NULL
);
GO

CREATE TABLE MidiEffects (
                         ID INT PRIMARY KEY IDENTITY(1,1),
                         MusicDeviceID INT NOT NULL,
                         EffectsDetailsID INT NOT NULL,
                         MidiCcValueTypeID INT NOT NULL,
                         CcChannel INT NOT NULL,
                         CcNumber INT NOT NULL,
                         CcValueMin INT NOT NULL,
                         CcValueMax INT NOT NULL,
                         CcValue INT NOT NULL
                         FOREIGN KEY (MusicDeviceID) REFERENCES MusicDevices(ID),
                         FOREIGN KEY (EffectsDetailsID) REFERENCES EffectDetails(ID),
                         FOREIGN KEY (MidiCcValueTypeID) REFERENCES MidiCcValueTypes(ID)
);
GO

CREATE TABLE MidiEffectModes (
                                  ID INT PRIMARY KEY IDENTITY(1,1),
                                  MidiEffectID INT NOT NULL,
                                  EffectDetailsID INT NOT NULL,
                                  SelectorCcValue INT NOT NULL,
                                  FOREIGN KEY (MidiEffectID) REFERENCES MidiEffects(ID),
                                  FOREIGN KEY (EffectDetailsID) REFERENCES EffectDetails(ID)
);
GO

CREATE TABLE MidiEffectSettings (
                                  ID INT PRIMARY KEY IDENTITY(1,1),
                                  MidiEffectID INT NOT NULL,
                                  MidiEffectSettingEffectID INT NOT NULL,
                                  FOREIGN KEY (MidiEffectID) REFERENCES MidiEffects(ID),
                                  FOREIGN KEY (MidiEffectSettingEffectID) REFERENCES MidiEffects(ID)
);
GO

CREATE TABLE MidiEffectSettingSettingss (
                                    ID INT PRIMARY KEY IDENTITY(1,1),
                                    MidiSettingEffectID INT NOT NULL,
                                    EffectDetailsID INT NOT NULL,
                                    FOREIGN KEY (MidiSettingEffectID) REFERENCES MidiEffects(ID),
                                    FOREIGN KEY (EffectDetailsID) REFERENCES EffectDetails(ID)
);
GO