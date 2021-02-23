local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIEnergyBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 110,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 50}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 95,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = { 
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 300}},
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1HydroCarbon',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T1Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
            { EBC, 'LessThanEconStorageRatio', { 1, 0.6}},
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
        BuilderName = 'SCTAAI T1Engineer Pgen2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 25,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FUSION} },
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
        BuilderName = 'SCTAAI T2Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 95,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FUSION} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, categories.FUSION} },
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            NeedGuard = false,
            Construction = {
                BuildStructures = {
                    'T2EnergyProduction',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T3Engineer Pgen',
        PlatoonTemplate = 'EngineerBuilderSCTA3',
        Priority = 110,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1000} }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.5}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LEVEL3 * categories.FUSION} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.FUSION} },
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildStructures = {
                    'T3EnergyProduction',
                }
            }
        }
    },
}