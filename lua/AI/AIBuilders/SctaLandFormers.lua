local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAILandFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI AntiAir',
        PlatoonTemplate = 'AntiAirSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 200,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseMoveOrder = true,
            UseFormation = 'AttackFormation',
            AntiAir = true,
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.ANTIAIR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Laser',
        PlatoonTemplate = 'StrikeForceSCTALaser', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 200,
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            Energy = true,
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
            { TAutils, 'GreaterEnergyStorageMaxTA', { 0.2 } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0,  categories.LASER * categories.MOBILE} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Early',
        PlatoonTemplate = 'LandAttackSCTAEarly', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 30,
        PriorityFunction = TAPrior.UnitProductionT1,
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 10,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND - categories.ENGINEER}},
        },
    },
    Builder {
        BuilderName = 'SCTAAI Missile Hunt',
        PlatoonTemplate = 'LandRocketAttackSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 115,
        InstanceCount = 30,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 10,
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND * ( categories.SILO + categories.ARTILLERY)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Mid',
        PlatoonTemplate = 'LandAttackSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 115,
        InstanceCount = 100,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND - categories.ENGINEER}},
            { MIBC, 'GreaterThanGameTime', {300} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Mid',
        PlatoonTemplate = 'StrikeForceSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 150,
        InstanceCount = 100,
        BuilderType = 'Any',
        BuilderData = {
            Small = true,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND - categories.ENGINEER}},
        },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Endgame',
        PlatoonTemplate = 'LandAttackSCTAEndGame', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 210,
        InstanceCount = 50,
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            ThreatWeights = {
            SecondaryTargetThreatType = 'StructuresNotMex',
            IgnoreStrongerTargetsRatio = 100.0,
            },
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND - categories.ENGINEER}},
        },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Endgame',
        PlatoonTemplate = 'StrikeForceSCTAEndgame', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.StructureProductionT3,
        Priority = 250,
        InstanceCount = 50,
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.LAND - categories.ENGINEER}},
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
}

