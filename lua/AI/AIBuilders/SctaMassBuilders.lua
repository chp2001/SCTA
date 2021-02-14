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
    BuilderGroupName = 'SCTAAIEngineerMassBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Mex 150',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 95,
        InstanceCount = 2, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 150, -500, 0, 0, 'AntiSurface', 1 }},
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
        BuilderName = 'SCTAAI T1Engineer 300 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 300, -500, 1, 0, 'AntiSurface', 1 }},
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
        BuilderName = 'SCTAAI T1Engineer 450 Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 85,
        InstanceCount = 1,
        BuilderConditions = {
                { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.1}},
                { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 450, -500, 1, 0, 'AntiSurface', 1 }},
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
        BuilderName = 'SCTAAI T1Engineer MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        Priority = 90,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2,  categories.FUSION} }, 
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 1.05 }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            DesiresAssist = true,
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                BuildStructures = {
                    'T1MassCreation',
                }
            }
        }
    },
    Builder {
        BuilderName = 'SCTAAI T2Engineer Mex',
        PlatoonTemplate = 'EngineerBuilderSCTA23',
        Priority = 100,
        InstanceCount = 1, -- The max number concurrent instances of this builder.
        BuilderConditions = {
            { MABC, 'CanBuildOnMassLessThanDistance', { 'LocationType', 100, -500, 0, 0, 'AntiSurface', 1 }},
         },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T2Resource',
                }
            }
        }
    },
}