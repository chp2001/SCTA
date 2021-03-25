local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0,  categories.SCOUT } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Radar Scout',
        PlatoonTemplate = 'SCTAT2AirScouting',
        Priority = 125,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.SCOUT } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Air Attack',
        PlatoonTemplate = 'SCTABomberAttack',
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
        BuilderName = 'SCTAAI Air Intercept Omni',
        PlatoonTemplate = 'InceptorAISCTA',
        Priority = 100,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            Stealth = true,
        },        
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
            { MIBC, 'LessThanGameTime', {300} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.ANTIAIR } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Stealth Intercept',
        PlatoonTemplate = 'StealthFightersAISCTA',
        Priority = 150,
        InstanceCount = 200,
        BuilderType = 'Any',  
        BuilderData = {
            Stealth = true,
        },   
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AIR * categories.ANTIAIR } },
        },
    },
}