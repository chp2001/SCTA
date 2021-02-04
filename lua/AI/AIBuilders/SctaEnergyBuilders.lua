local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local SIBC = '/lua/editor/SorianInstantBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIEnergyBuilder',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTAAI T1Engineer Hydro',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = { -- The build conditions determine if this builder is available to be used or not.	
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
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.WIND} },
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
        BuilderName = 'SCTAAI T1Engineer Pgen2',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        InstanceCount = 1,
        BuilderConditions = {
            { EBC, 'LessThanEconStorageRatio', { 1.1, 0.99}}, -- If less than full energy, build a pgen.
        },
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
            Construction = {
                BuildStructures = {
                    'T1GroundDefense',
                    'T1EnergyProduction',
                    'T1EnergyProduction',
                    'T1AirFactory',
                }
            }
        }
    },  
    Builder {
        BuilderName = 'SCTAAI T1Engineer MetalMaker',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        Priority = 50,
        BuilderConditions = {
                { MIBC, 'GreaterThanGameTime', {600} }, -- Don't make tanks if we have lots of them.
                { SIBC, 'LessThanEconEfficiencyOverTime', { 0.91, 2.0}},
                { SIBC, 'GreaterThanEconEfficiencyOverTime', { 0.4, 1.25}},
                { EBC, 'LessThanEconStorageRatio', { 0.75, 2 } },
                { SIBC, 'HaveGreaterThanUnitsWithCategory', { 6, 'ENERGYPRODUCTION' } },
                { IBC, 'BrainNotLowPowerMode', {} },
            },
        BuilderType = 'Any',
        BuilderData = {
            NumAssistees = 2,
            Construction = {
                BuildClose = true,
                AdjacencyCategory = 'ENERGYPRODUCTION',
                BuildStructures = {
                    'T1MassCreation',
                },
            }
        }
    },
}