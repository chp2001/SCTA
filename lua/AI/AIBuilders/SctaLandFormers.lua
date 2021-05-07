local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
local RAIDER = (categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.armspid + categories.armflea)
local SPECIAL = (RAIDER + categories.EXPERIMENTAL + categories.ENGINEER + categories.SCOUT)
local GROUND = categories.MOBILE * categories.LAND
local TACATS = (categories.ANTISHIELD + categories.AMPHIBIOUS)
local RANGE = (categories.ARTILLERY + categories.SILO + categories.ANTIAIR)

BuilderGroup {
    BuilderGroupName = 'SCTAAILandFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI AntiAir',
        PlatoonTemplate = 'AntiAirSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'SCTAStrikeForceAIEarly',
        Priority = 100,
        InstanceCount = 50,
        BuilderType = 'LandForm',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseMoveOrder = true,
            UseFormation = 'AttackFormation',
            AntiAir = true,
        },        
        BuilderConditions = {
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 2,  GROUND * categories.ANTIAIR - categories.ANTISHIELD} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Scout',
        PlatoonTemplate = 'T1LandScoutFormSCTA',
        Priority = 125,
        InstanceCount = 2,
        BuilderType = 'Scout',
        BuilderData = {
        LocationType = 'LocationType',
        },
        BuilderConditions = {
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, categories.SCOUT * categories.LAND * categories.MOBILE } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Laser',
        PlatoonTemplate = 'StrikeForceSCTALaser', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 200,
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 25,
        --DelayEqualBuildPlattons = 5,
        BuilderType = 'LandForm',
        BuilderData = {
            ThreatSupport = 75,
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
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 2, GROUND * (categories.ANTISHIELD + categories.FIELDENGINEER) - categories.AMPHIBIOUS - categories.EXPERIMENTAL} },
            { TAutils, 'GreaterEnergyStorageMaxTA', { 0.2 } },
        },
    },
---Defensive/MidGame Platoons
    Builder {
        BuilderName = 'SCTAAI Strike Force Early',
        PlatoonTemplate = 'StrikeForceSCTAEarly', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'SCTAStrikeForceAIEarly',
        Priority = 100,
        InstanceCount = 50,
        PriorityFunction = TAPrior.UnitProductionT1,
        BuilderType = 'LandForm',
        BuilderData = {
            ThreatSupport = 75,
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, GROUND * categories.TECH1 - SPECIAL - RANGE - TACATS}},
        },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Mid',
        PlatoonTemplate = 'StrikeForceSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'SCTAStrikeForceAI', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 150,
        InstanceCount = 50,
        BuilderType = 'LandForm',
        BuilderData = {
            ThreatSupport = 75,
            Small = true,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 4, GROUND - SPECIAL}},
        },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Endgame',
        PlatoonTemplate = 'StrikeForceSCTAEndgame', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'SCTAStrikeForceAIEndgame', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.StructureProductionT2,
        Priority = 250,
        InstanceCount = 50,
        BuilderType = 'AirForm',
        BuilderData = {
            ThreatSupport = 75,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
            LocationType = 'LocationType',
        },        
        BuilderConditions = {
            --{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 9, GROUND - SPECIAL}},
        },
    },
    ----AggressivePlatoons
    Builder {
        BuilderName = 'SCTAAI Missile Hunt',
        PlatoonTemplate = 'LandRocketAttackSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'HuntSCTAAI',
        Priority = 125,
        InstanceCount = 50,
        BuilderType = 'LandForm',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, GROUND * (RANGE + categories.FIELDENGINEER)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Mid',
        PlatoonTemplate = 'LandAttackSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'AttackSCTAForceAI',
        PriorityFunction = TAPrior.UnitProductionT1, -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 115,
        InstanceCount = 25,
        --DelayEqualBuildPlattons = 5,
        BuilderType = 'LandForm',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 4, GROUND * (RANGE + categories.FIELDENGINEER)}},
            { MIBC, 'GreaterThanGameTime', {300} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Endgame',
        PlatoonTemplate = 'LandAttackSCTAEndGame', -- The platoon template tells the AI what units to include, and how to use them.
        PlatoonAIPlan = 'AttackSCTAForceAIEndGame', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.TechEnergyExist,
        Priority = 210,
        InstanceCount = 50,
        BuilderType = 'AirForm',
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
            --{ UCBC, 'PoolGreaterAtLocation', { 'LocationType', 9, GROUND * (RANGE + categories.FIELDENGINEER)} },
        },
    },
}

