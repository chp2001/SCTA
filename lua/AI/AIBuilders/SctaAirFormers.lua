local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIAirFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI Air Scout',
        PlatoonTemplate = 'T1AirScoutFormSCTA',
        Priority = 100,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.SCOUT } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Air Attack',
        PlatoonTemplate = 'BomberAttack',
        Priority = 100,
        InstanceCount = 3,
        BuilderType = 'Any',        
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.BOMBER } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept',
        PlatoonTemplate = 'IntieAISCTA',
        Priority = 100,
        InstanceCount = 200,
        BuilderType = 'Any',     
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.ANTIAIR } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Hunt',
        PlatoonTemplate = 'AirHuntAISCTA',
        Priority = 125,
        InstanceCount = 2,
        BuilderType = 'Any',     
        BuilderConditions = { 
            { MIBC, 'LessThanGameTime', {600} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.ANTIAIR } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Stealth Intercept',
        PlatoonTemplate = 'StealthFightersAISCTA',
        Priority = 150,
        InstanceCount = 200,
        BuilderType = 'Any',     
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.ANTIAIR } },
        },
    },
}