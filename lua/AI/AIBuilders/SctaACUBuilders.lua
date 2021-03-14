local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAICommanderBuilder', -- Globally unique key that the AI base template file uses to add the contained builders to your AI.	
    BuildersType = 'EngineerBuilder',-- The kind of builder this is.  One of 'EngineerBuilder', 'PlatoonFormBuilder', or 'FactoryBuilder'.
    -- The initial build order
    Builder {
        BuilderName = 'SCTAAI Initial Commander BO', -- Names need to be GLOBALLY unique.  Prefixing the AI name will help avoid name collisions with other AIs.	
        PlatoonTemplate = 'CommanderBuilderSCTA', -- Specify what platoon template to use, see the PlatoonTemplates folder.	
        Priority = 1000, -- Make this super high priority.  The AI chooses the highest priority builder currently available.	
        BuilderConditions = { -- The build conditions determine if this builder is available to be used or not.	
                { IBC, 'NotPreBuilt', {}},
            },	
        InstantCheck = true,	
        BuilderType = 'Any',	
        PlatoonAddBehaviors = { 'CommanderBehaviorSCTA' }, -- Add a behaviour to the Commander unit once its done with it's BO.	
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, }, -- Flag this builder to be only run once.	
        BuilderData = {	
            Construction = {
                BuildStructures = { -- The buildings to make	
                'T1LandFactory',	
                'T1EnergyProduction',
                'T1EnergyProduction',
                }	
            }	
        }	
    },
    Builder {
        BuilderName = 'SCTA AI ACU Factory',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 925,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {240} }, -- Don't make tanks if we have lots of them.
            { MIBC, 'GreaterThanGameTime', {90} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.PLANT} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.1}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA  ACU Energy',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 950,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.SOLAR} },
            { MIBC, 'LessThanGameTime', {180} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA AI ACU Mex',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 975,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {180} }, -- Don't make tanks if we have lots of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.MASSEXTRACTION} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA AI ACU T1Engineer Mex',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} }, -- Don't make tanks if we have lots of them.
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 250, -500, 200, 0, 'AntiSurface', 1 }},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1Resource',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI ACU T1Pgen',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 60,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {600} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.WIND } }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Commander LandFac',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB } }, -- Stop after 10 facs have been built.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 12, categories.PLANT} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = false,
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory2',
                }
            }
        }
    },    
    Builder {
        BuilderName = 'SCTAAI T1Commander AirFac',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.AIR } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1AirFactory',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTA Mex Assist Commander',
        PlatoonTemplate = 'CommanderSCTAAssist',
        Priority = 25,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'BuildingGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * categories.LEVEL2}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistUntilFinished = true,
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                BeingBuiltCategories = {'MASSEXTRACTION'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Commander Assist Gantry Construction',
        PlatoonTemplate = 'CommanderSCTAAssist',
        Priority = 125,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GANTRY }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'GANTRY'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
Builder {
    BuilderName = 'SCTA Commander Assist Gantry',
    PlatoonTemplate = 'CommanderSCTAAssist',
    Priority = 110,
    InstanceCount = 1,
    BuilderConditions = {
        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.BUILTBYGANTRY }},
        { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.6, 0.5 } },
        { IBC, 'BrainNotLowPowerMode', {} },
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Factory',
            BeingBuiltCategories = {'BUILTBYGANTRY'},
            Time = 20,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA CDR Assist Fusion',
        PlatoonTemplate = 'CommanderSCTAAssist',
        Priority = 120,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.FUSION }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.6, 0.5 } },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'FUSION'},
                Time = 20,
            },
        }
    },
}
