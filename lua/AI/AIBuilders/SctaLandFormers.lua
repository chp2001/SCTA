local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
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
        BuilderName = 'SCTAAI Strike',
        PlatoonTemplate = 'StrikeForceSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 120,
        InstanceCount = 25,
        BuilderType = 'Any',
        BuilderData = {
            Small = true,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {540} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Laser',
        PlatoonTemplate = 'StrikeForceSCTALaser', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 150,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            Small = true,
            Laser = true,
            FormRadius = 500,
            NeverGuardBases = false,
            NeverGuardEngineers = true,
            UseMoveOrder = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
        },
    },
    Builder {
        BuilderName = 'SCTAAI Rocket Strike',
        PlatoonTemplate = 'StrikeForceSCTAMissiles', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 130,
        InstanceCount = 50,
        BuilderType = 'Any',
        BuilderData = {
            Small = true,
            NeverGuardBases = false,
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
        Priority = 120,
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 5, categories.MOBILE * categories.LAND * ( categories.DIRECTFIRE + categories.INDIRECTFIRE)} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Early',
        PlatoonTemplate = 'LandAttackSCTAEarly', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 30,
        FormRadius = 1000,
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
            { MIBC, 'LessThanGameTime', {600} }, -- Don't make tanks if we have lots of them.
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land2 Rocket Attack',
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
        BuilderName = 'SCTA Engineer Reclaim Field',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        Priority = 200,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            { TAutils, 'TAReclaimablesInArea', { 'LocationType', }},
        },
        BuilderData = {
        Terrain = true,
        LocationType = 'LocationType',
        ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Field Finish',
        PlatoonTemplate = 'EngineerBuilderSCTAFieldFinish',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
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
    Builder {
        BuilderName = 'SCTA Assist Production Field',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 25,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.FACTORY }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'FACTORY'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Mid',
        PlatoonTemplate = 'LandAttackSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 125,
        InstanceCount = 10,
        FormRadius = 1000,
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
            { MIBC, 'GreaterThanGameTime', {600} },
            { MIBC, 'LessThanGameTime', {1200} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Mid',
        PlatoonTemplate = 'StrikeForceSCTAMid', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 150,
        InstanceCount = 10,
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {750} },
            { MIBC, 'LessThanGameTime', {1500} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Land Attack Endgame',
        PlatoonTemplate = 'LandAttackSCTAEndGame', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 210,
        InstanceCount = 10,
        FormRadius = 1000,
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
            { MIBC, 'GreaterThanGameTime', {1200} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Strike Endgame',
        PlatoonTemplate = 'StrikeForceSCTAEndgame', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 250,
        InstanceCount = 10,
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
         },
    },
}

