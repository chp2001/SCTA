local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAILandFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI LAB',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 90,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack',
        PlatoonTemplate = 'LandAttackSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
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
        BuilderName = 'LV4Kbot',
        PlatoonTemplate = 'T4ExperimentalSCTA',
        Priority = 10000,
        FormRadius = 10000,
        InstanceCount = 50,
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

