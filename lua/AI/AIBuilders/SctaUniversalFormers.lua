local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetMOARadii()
local RAIDAIR = categories.armfig + categories.corveng + categories.GROUNDATTACK
local RAIDER = RAIDAIR + categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.armspid + categories.armflea
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAIUniversalFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI Guard',
        PlatoonTemplate = 'GuardSCTA',
        PlatoonAIPlan = 'GuardEngineer',
        PriorityFunction = TAPrior.LessThanTime,
        Priority = 100,
        InstanceCount = 6,
        BuilderType = 'Land',
        BuilderData = {
            NeverGuardBases = true,
            LocationType = 'LocationType',
        },        
        BuilderConditions = {
            { UCBC, 'EngineersNeedGuard', { 'LocationType' } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.ANTIAIR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Terrain',
        PlatoonTemplate = 'StrikeForceSCTATerrain', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 200,
        InstanceCount = 2,
        BuilderType = 'Land',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseMoveOrder = true,
            AllTerrain = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {          
        { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.COMMAND }},	
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AMPHIBIOUS - categories.SCOUT} }, },
    },
    Builder {
        BuilderName = 'SCTAAI LAB',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'Land',
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { 
            { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.COMMAND }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, RAIDER} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI LAB Interceptor',
        PlatoonTemplate = 'LABAirSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.LessThanTime,
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'Air',
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { 
            { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.ANTIAIR }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, RAIDAIR} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Hunt',
        PlatoonTemplate = 'AirHuntAISCTA',
        Priority = 300,
        InstanceCount = 2,
        BuilderType = 'Air', 
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },     
        BuilderConditions = { 
            { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.ANTIAIR }},	
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.BOMBER + RAIDAIR} },
        },
    },
    Builder {
        BuilderName = 'LV4Kbot',
        PlatoonTemplate = 'T4ExperimentalSCTA',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 10000,
        FormRadius = 10000,
        InstanceCount = 2,
        BuilderType = 'Land',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.EXPERIMENTAL * categories.MOBILE - categories.ENGINEER } },
         },
        BuilderData = {
            ThreatWeights = {
                TargetThreatType = 'Commander',
            },
            UseMoveOrder = true,
            PrioritizedCategories = { 'COMMAND', 'FACTORY -NAVAL', 'EXPERIMENTAL', 'MASSPRODUCTION', 'STRUCTURE -NAVAL' },
        },
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PriorityFunction = TAPrior.LessThanTime,
        PlatoonAIPlan = 'SCTAReclaimAI',
        FormRadius = 500,
        Priority = 150,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 120 } }, 
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.25}},   
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Engineer',
    },
    Builder {
        BuilderName = 'SCTA Assist Production Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.AssistProduction,
        Priority = 5,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.STRUCTURE }},
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 20,
                BeingBuiltCategories = {'STRUCTURE'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Engineer',
    },
    Builder {
        BuilderName = 'SCTA Assist Unit Production Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.AssistProduction,
        Priority = 5,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.MOBILE }},
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                PermanentAssist = false,
                BeingBuiltCategories = {'MOBILE'},                                        
                Time = 60,
            },
        },
        BuilderType = 'Engineer',
    },
    Builder {
        BuilderName = 'SCTANukeAI',
        PlatoonTemplate = 'NuclearMissileSCTA',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 300,
        BuilderConditions = {
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.NUKE * categories.STRUCTURE * categories.TECH3}},
            },
        BuilderType = 'Structure',
        FormRadius = 10000,
    },
    Builder {
        BuilderName = 'SCTAAntiNukeAI',
        PlatoonTemplate = 'AntiNuclearMissileSCTA',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 300,
        BuilderConditions = {
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3}},
            },
        BuilderType = 'Structure',
        FormRadius = 10000,
    },
}

