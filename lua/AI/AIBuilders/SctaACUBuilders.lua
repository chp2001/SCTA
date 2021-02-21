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
                BuildClose = true,
                BuildStructures = { -- The buildings to make	
                'T1LandFactory',	
                'T1EnergyProduction',
                'T1Resource',
                }	
            }	
        }	
    },
    Builder {
        BuilderName = 'SCTA AI ACU Factory',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 950,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {240} }, -- Don't make tanks if we have lots of them.
            { MIBC, 'GreaterThanGameTime', {90} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.3}},
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
        Priority = 960,
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.MASSEXTRACTION} },
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
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {800} }, -- Don't make tanks if we have lots of them.
            { EBC, 'LessThanEconStorageRatio', { 0.5, 1}},
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
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {450} },
            { EBC, 'LessThanEconStorageRatio', { 1, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1EnergyProduction2',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Commander LandFac',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.LAB } }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2, 
            NeedGuard = false,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1LandFactory',
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
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.AIR } }, -- Stop after 10 facs have been built.
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
        BuilderName = 'SCTA CDR Assist Fusion',
        PlatoonTemplate = 'CommanderSCTAAssist',
        Priority = 75,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, 'FUSION' }},
            { EBC, 'LessThanEconEfficiencyOverTime', { 2.0, 1.5 }},
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
Builder {
    BuilderName = 'SCTA Commander Assist Gantry',
    PlatoonTemplate = 'CommanderSCTAAssist',
    Priority = 50,
    BuilderConditions = {
        { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.6, 0.5 } },
        { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, 'LEVEL4' }},
        { IBC, 'BrainNotLowPowerMode', {} },
    },
    BuilderType = 'Any',
    BuilderData = {
        Assist = {
            AssistLocation = 'LocationType',
            AssisteeType = 'Factory',
            BeingBuiltCategories = {'LEVEL4'},
            Time = 20,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Commander Finish',
        PlatoonTemplate = 'CommanderSCTAAssist',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 25,
        InstanceCount = 2,
        BuilderConditions = {
                { UCBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC, STRUCTURE ECONOMIC, STRUCTURE'},
                Time = 20,
            },
        },
        BuilderType = 'Any',
    },
}
