local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAILandFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI AntiAir',
        PlatoonTemplate = 'AntiAirSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 85,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * categories.ANTIAIR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Scout',
        PlatoonTemplate = 'T1LandScoutFormSCTA',
        Priority = 125,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.SCOUT } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Gaurd',
        PlatoonTemplate = 'GaurdSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 150,
        InstanceCount = 4,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
         },
    },
    Builder {
        BuilderName = 'SCTAAI Strike',
        PlatoonTemplate = 'StrikeForceSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 90,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {900} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Laser',
        PlatoonTemplate = 'StrikeForceSCTALaser', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 90,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            Laser = true,
            NeverGuardBases = false,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
            { EBC, 'GreaterThanEconStorageCurrent', { 10, 500 } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Terrain',
        PlatoonTemplate = 'StrikeForceSCTATerrain', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 150,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { },
    },
    Builder {
        BuilderName = 'SCTAAI LAB',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack',
        PlatoonTemplate = 'LandAttackSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 95,
        InstanceCount = 100,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            AggressiveMove = false,
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Early',
        PlatoonTemplate = 'LandAttackSCTAEarly', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 30,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            AggressiveMove = true,
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} }, -- Don't make tanks if we have lots of them.
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land2 Attack',
        PlatoonTemplate = 'LandRocketAttackSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 105,
        InstanceCount = 30,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            AggressiveMove = true,
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'LV4Kbot',
        PlatoonTemplate = 'T4ExperimentalSCTA',
        Priority = 10000,
        FormRadius = 10000,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderData = {
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'COMMAND', 'FACTORY -NAVAL', 'EXPERIMENTAL', 'MASSPRODUCTION', 'STRUCTURE -NAVAL' }, # list in order
        },
    },
}

