
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local WIND = (categories.armwin + categories.corwin)
local SOLAR = (categories.armsolar + categories.corsolar)
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAssisters',
    BuildersType = 'PlatoonFormBuilder',
    ----Building Reclaim
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 100,
        FormRadius = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, PLANT}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLANT} },
            { TAutils, 'LessMassStorageMaxTA', { 0.2}},    
            },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'TECH1 FACTORY,'},
        },
        BuilderType = 'EngineerForm',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        PriorityFunction = TAPrior.TechEnergyExist,
        Priority = 85,
        FormRadius = 100,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, WIND + SOLAR}},
            { TAutils, 'GreaterThanEconEnergyTAEfficiency', {1.05 }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'armsolar, corsolar, armwin, corwin,'},
                ReclaimTime = 30,
        },
        BuilderType = 'EngineerForm',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Air',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 125,
        FormRadius = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.ENGINEER}},
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            },
        BuilderData = {
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'EngineerForm',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'SCTAReclaimAI',
        FormRadius = 100,
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 240 } },
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},  
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'EngineerForm',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.COMMAND + categories.SUBCOMMANDER} },
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
        BuilderType = 'Other',
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
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.COMMAND + categories.SUBCOMMANDER} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Other',
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
    Builder {
        BuilderName = 'SCTA Engineer Finish',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 85,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'Unfinished', 2},
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA', { 'Unfinished' }},
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
        BuilderType = 'EngineerForm',
    },
    Builder {
        BuilderName = 'SCTA PGen Field Assist',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.EnergyBeingBuilt,
        Priority = 75,
        InstanceCount = 2,
        FormRadius = 100,
        BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.5, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Other',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'TECH2 ENERGYPRODUCTION STRUCTURE, TECH3 ENERGYPRODUCTION STRUCTURE,'},
                Time = 20,
                AssistRange = 120,
                AssistUntilFinished = true,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Field',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PriorityFunction = TAPrior.UnitProductionField,
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 200,
        FormRadius = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.AIR * categories.ENGINEER}},
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
        },
        BuilderType = 'Other',
    },
    Builder {
        BuilderName = 'SCTA Engineer Field Finish',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PriorityFunction = TAPrior.UnitProductionField,
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 125,
        InstanceCount = 2,
        DelayEqualBuildPlattons = {'Unfinished', 2},
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA', { 'Unfinished' }},
            { UCBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.FIELDENGINEER} },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {'STRUCTURE STRATEGIC, STRUCTURE ECONOMIC, STRUCTURE'},
                Time = 20,
            },
        },
        BuilderType = 'Other',
    },
    Builder {
        BuilderName = 'SCTA Assist Production Field',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PlatoonAIPlan = 'ManagerEngineerAssistAI',
        PriorityFunction = TAPrior.UnitProductionField,
        Priority = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.STRUCTURE * (categories.TECH2 + categories.TECH3)}},
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'STRUCTURE TECH2, STRUCTURE TECH3,'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Other',
    },
}