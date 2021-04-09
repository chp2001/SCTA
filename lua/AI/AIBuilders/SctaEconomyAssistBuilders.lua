
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/TAAIutils.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE


BuilderGroup {
    BuilderGroupName = 'SCTAAssisters',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA PGen Assist',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 75,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, FUSION }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 0.5 } },
        },
        BuilderType = 'Any',
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
        BuilderName = 'SCTA Engineer Assist Gantry Production',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 200,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GATE }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
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
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Assist Production Field',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 25,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.FACTORY }},
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
        BuilderName = 'SCTA Assist Production Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA123Assist',
        Priority = 5,
        InstanceCount = 11,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.STRUCTURE }},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'STRUCTURE'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Assist Unit Production Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA123Assist',
        Priority = 5,
        InstanceCount = 14,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.MOBILE }},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 120,
                BeingBuiltCategories = {'MOBILE'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Assist Gantry',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 200,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.BUILTBYQUANTUMGATE }},
            { EBC, 'GreaterThanEconStorageRatio', { 0.75, 0.5}},
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 120,
                BeingBuiltCategories = {'BUILTBYQUANTUMGATE'},                                                       
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    ----Building Reclaim
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, PLANT * categories.LAND}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, LAB * categories.LAND} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLANT * categories.LAND} },
            { TAutils, 'LessMassStorageMaxTA', { 0.1}},
            { EBC, 'LessEconStorageCurrent', { 100, 6000 } },    
            },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'TECH1 FACTORY LAND'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim T1 PLANTS AIR',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 275,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, PLANT * categories.AIR}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLANT * categories.AIR} },
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            { EBC, 'LessEconStorageCurrent', { 100, 1000 } },    
        },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'TECH1 FACTORY AIR'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 89,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, FUSION} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.VOLATILE}},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'VOLATILE'},
                ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy Wind',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 88,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 1, FUSION} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.ENERGYPRODUCTION * categories.TECH1 * categories.STRUCTURE}},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'STRUCTURE ENERGYPRODUCTION TECH1'},
                ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Finish',
        PlatoonTemplate = 'EngineerBuilderSCTAEco12',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
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
        BuilderName = 'SCTA Engineer Reclaim Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 25,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 360 } },
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}},   
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
        BuilderName = 'SCTA Engineer Reclaim Air',
        PlatoonTemplate = 'EngineerBuilderSCTAEco123',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 85,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { TAutils, 'LessMassStorageMaxTA',  { 0.3}}, 
            { TAutils, 'TAReclaimablesInArea', { 'LocationType', }},   
            },
        BuilderData = {
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
}