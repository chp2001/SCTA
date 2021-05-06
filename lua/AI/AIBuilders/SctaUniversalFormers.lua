local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea = import('/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua').GetMOARadii()
local RAIDAIR = categories.armfig + categories.corveng + categories.GROUNDATTACK
local RAIDER = categories.armpw + categories.corak + categories.armflash + categories.corgator + categories.armspid + categories.armflea
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
local EBC = '/lua/editor/EconomyBuildConditions.lua'

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
        BuilderType = 'CommandTA',
        BuilderData = {
            NeverGuardBases = true,
            LocationType = 'LocationType',
        },        
        BuilderConditions = {
            { UCBC, 'EngineersNeedGuard', { 'LocationType' } },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MOBILE * categories.ANTIAIR * categories.LAND} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Terrain',
        PlatoonTemplate = 'StrikeForceSCTATerrain', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 200,
        InstanceCount = 2,
        BuilderType = 'CommandTA',
        BuilderData = {
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseMoveOrder = true,
            AllTerrain = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = {          
        { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.COMMAND }},	
        { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.AMPHIBIOUS - categories.SCOUT - categories.COMMAND - categories.ENGINEER} }, },
    },
    Builder {
        BuilderName = 'SCTAAI LAB',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        Priority = 150,
        InstanceCount = 5,
        PriorityFunction = TAPrior.UnitProductionLab,
        BuilderType = 'CommandTA',
        BuilderData = {
            Lab = true,
            NeverGuardBases = true,
            NeverGuardEngineers = true,
            UseFormation = 'AttackFormation',
        },        
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, RAIDER} },
            { TASlow, 'EnemyUnitsLessAtLocationRadius', { BaseEnemyArea, 'LocationType', 1, categories.COMMAND }},	
        },
    },
    Builder {
        BuilderName = 'SCTAAI LAB Interceptor',
        PlatoonTemplate = 'LABSCTA', -- The platoon template tells the AI what units to include, and how to use them.
        PriorityFunction = TAPrior.LessThanTime,
        Priority = 300,
        InstanceCount = 5,
        BuilderType = 'CommandTA',
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
        BuilderType = 'AirForm', 
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
        InstanceCount = 2,
        BuilderType = 'CommandTA',
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
        Priority = 150,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 120 } }, 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.ENGINEER - categories.COMMAND} },
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.25}},   
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'EngineerForm',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.ENGINEER - categories.COMMAND} },
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
        BuilderType = 'EngineerForm',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 2, categories.ENGINEER - categories.COMMAND} },
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
        BuilderType = 'EngineerForm',
    },
    Builder {
        BuilderName = 'SCTANukeAI',
        PlatoonTemplate = 'NuclearMissileSCTA',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 300,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NUKE * categories.STRUCTURE * categories.TECH3} },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.NUKE * categories.STRUCTURE * categories.TECH3}},
            },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTAAntiNukeAI',
        PlatoonTemplate = 'AntiNuclearMissileSCTA',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 300,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ANTIMISSILE * categories.STRUCTURE * categories.TECH3}},
            },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTA Engineer Assist Gantry Production',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        Plan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.GateBeingBuilt,
        Priority = 200,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GATE }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'GATE'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTA Engineer Assist Gantry',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        Plan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.GantryProduction,
        Priority = 200,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.BUILTBYQUANTUMGATE}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                PermanentAssist = false,
                BeingBuiltCategories = {'BUILTBYQUANTUMGATE'},                                                       
                Time = 60,
            },
        },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTA Commander Assist Hydro',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        Plan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.HydroBeingBuiltACU,
        Priority = 980,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {180} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.COMMAND} },
            { MABC, 'MarkerLessThanDistance',  { 'Hydrocarbon', 50}},
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.HYDROCARBON }},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'HYDROCARBON'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTA Commander Assist Gantry Construction',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.GateBeingBuilt,
        Priority = 126,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GATE }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.ENGINEER * (categories.COMMAND + categories.SUBCOMMANDER)} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'GATE'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'CommandTA',
    },
    Builder {
        BuilderName = 'SCTA CDR Assist Structure',
        PlatoonTemplate = 'CommanderBuilderSCTA',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 111,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.STRUCTURE }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.ENGINEER * (categories.COMMAND + categories.SUBCOMMANDER)} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'CommandTA',
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssisteeCategory = 'Engineer',
                AssistRange = 20,
                BeingBuiltCategories = {'STRUCTURE'},                                        
                AssistUntilFinished = true,
            },
        },
    },
}

