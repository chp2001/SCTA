local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
local TIDAL = (categories.cortide + categories.armtide)

BuilderGroup {
    BuilderGroupName = 'SCTANavalFormer',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'SCTA Scout Ships',
        PlatoonTemplate = 'SCTAPatrolBoatAttack',
        Priority = 150,
        InstanceCount = 4,
        BuilderType = 'Sea',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.SCOUT } },
         },
         BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Naval',
                SecondaryThreatTargetType = 'Economy',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
    },
    Builder {
        BuilderName = 'SCTA Hunt Ships',
        PlatoonTemplate = 'SCTAPatrolBoatHunt',
        Priority = 100,
        InstanceCount = 25,
        BuilderType = 'Sea',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.NAVAL * categories.SCOUT } },
         },
         BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Naval',
                SecondaryThreatTargetType = 'Economy',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
    },
    Builder {
        BuilderName = 'SCTA Sub Hunt Ships',
        PlatoonTemplate = 'SCTASubHunter',
        Priority = 100,
        InstanceCount = 5,
        BuilderType = 'Sea',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.SUBMERSIBLE - categories.ENGINEER} },
         },
         BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'AntiSub',
                SecondaryThreatTargetType = 'Naval',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
    },
    Builder {
        BuilderName = 'SCTA T1 Naval Assault',
        PlatoonTemplate = 'SCTANavalAssault',
        Priority = 110,
        InstanceCount = 10,
        BuilderType = 'Sea',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Naval',
                SecondaryThreatTargetType = 'Economy',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 3, categories.NAVAL * categories.MOBILE - categories.ENGINEER } },
        },
    },
    Builder {
        BuilderName = 'SCTA HighTech Naval',
        PlatoonTemplate = 'SCTANavalAssaultT2',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 120,
        InstanceCount = 10,
        BuilderType = 'Sea',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Economy',
                SecondaryThreatTargetType = 'Naval',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.MOBILE * (categories.TECH2 + categories.TECH3) - categories.ENGINEER} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Naval Intercept',
        PlatoonTemplate = 'IntieAISCTA',
        Priority = 100,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'AirUnitRefit' },                              
        InstanceCount = 200,
        BuilderType = 'Air',     
        BuilderConditions = { 
        },
    },
    Builder {
        BuilderName = 'SCTA Hover Strike',
        PlatoonTemplate = 'StrikeForceSCTAHover', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 120,
        InstanceCount = 25,
        BuilderType = 'Land',
        BuilderData = {
            Small = true,
            NeverGuardBases = false,
            NeverGuardEngineers = false,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.MOBILE * categories.HOVER} },
         },
    },
    Builder {
        BuilderName = 'SCTA Engineer Finish Navy',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 85,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'Unfinished', 2},
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA', { 'Unfinished' }},
            { UCBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
        },
        BuilderData = {
            Assist = {
                BeingBuiltCategories = {'STRUCTURE'},
                AssistLocation = 'LocationType',
                AssistUntilFinished = true,
                AssisteeType = 'Engineer',
                Time = 20,
            },
        },
        BuilderType = 'Engineer',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy Naval',
        PlatoonTemplate = 'EngineerBuilderSCTANaval',
        PriorityFunction = TAPrior.TechEnergyExist,
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 111,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, TIDAL}},
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'cortide, armtide,'},
            ReclaimTime = 30,
        },
        BuilderType = 'Engineer',
    },
}