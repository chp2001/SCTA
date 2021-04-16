local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTANavalFormer',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'SCTA Scout Ships',
        PlatoonTemplate = 'SCTAPatrolBoatAttack',
        Priority = 100,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.SCOUT } },
         },
         BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                AggressiveMove = false,
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
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.SUBMERSIBLE - categories.ENGINEER} },
         },
         BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                AggressiveMove = false,
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
        Priority = 50,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                AggressiveMove = false,
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.MOBILE - categories.ENGINEER } },
        },
    },
    Builder {
        BuilderName = 'SCTA HighTech',
        PlatoonTemplate = 'SCTANavalAssaultT2',
        Priority = 75,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Economy',
                SecondaryThreatTargetType = 'Naval',
                AggressiveMove = false,
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.MOBILE - categories.ENGINEER} },
        },
    },
}