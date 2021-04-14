local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetMOARadii()
local RAIDER = categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.armspid + categories.armflea
local RAIDAIR = categories.armfig + categories.corveng 


BuilderGroup {
    BuilderGroupName = 'SCTAAIUniversalFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI Guard',
        PlatoonTemplate = 'GuardSCTA',
        PlatoonAIPlan = 'GuardEngineer', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 100,
        InstanceCount = 6,
        BuilderType = 'Any',
        BuilderData = {
            NeverGuardBases = true,
            LocationType = 'LocationType',
        },        
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} },
            { UCBC, 'EngineersNeedGuard', { 'LocationType' } },
         },
    },
    Builder {
        BuilderName = 'SCTAAI LAB',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { 
            { UCBC, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.COMMAND }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, RAIDER} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI LAB Interceptor',
        PlatoonTemplate = 'LABAirSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'Any',
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { 
            { MIBC, 'LessThanGameTime', {600} },
            { UCBC, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.ANTIAIR }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, RAIDAIR} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Hunt',
        PlatoonTemplate = 'AirHuntAISCTA',
        Priority = 300,
        InstanceCount = 2,
        BuilderType = 'Any', 
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },     
        BuilderConditions = { 
            { MIBC, 'LessThanGameTime', {900} },
            { UCBC, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.ANTIAIR }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.BOMBER + RAIDAIR} },
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

