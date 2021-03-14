
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAssisters',
    BuildersType = 'EngineerBuilder',
    Builder {
        BuilderName = 'SCTA PGen Assist',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 75,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.FUSION }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssisteeType = 'Engineer',
                AssistLocation = 'LocationType',
                BeingBuiltCategories = {'FUSION'},
                Time = 20,
                AssistUntilFinished = true,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Mex Assist',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 90,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'BuildingGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * categories.LEVEL2}},
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistUntilFinished = true,
                AssistLocation = 'LocationType',
                AssisteeType = 'Structure',
                BeingBuiltCategories = {'MASSEXTRACTION'},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Assist Gantry Production',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 120,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.GANTRY }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'GANTRY'},                                                   
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Assist LEVEL2 Production',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 125,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'LocationEngineersBuildingAssistanceGreater', { 'LocationType', 0, categories.LAB }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.7, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                AssistRange = 120,
                BeingBuiltCategories = {'LAB'},                                        
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Assist Gantry',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 130,
        InstanceCount = 12,
        BuilderConditions = {
            { UCBC, 'LocationFactoriesBuildingGreater', { 'LocationType', 0, categories.EXPERIMENTAL }},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.6, 0.5 } },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Factory',
                AssistRange = 120,
                BeingBuiltCategories = {'EXPERIMENTAL'},                                                       
                AssistUntilFinished = true,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Field',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 75,
        InstanceCount = 3,
        BuilderConditions = {
            { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            { EBC, 'LessThanEconStorageRatio', { 0.25, 1.1}},
        },
        BuilderData = {
        LocationType = 'LocationType',
        ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess Early',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 130,
        InstanceCount = 5,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} }, 
            { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess Late',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 150,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 600 } },
            { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Air',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 200,
        InstanceCount = 10,
        BuilderConditions = {
            { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.PLANT * categories.LAND}},
            { EBC, 'LessThanEconStorageRatio', { 0.3, 1.1}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.LAB * categories.LAND} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.PLANT} },    
            },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'PLANT LAND'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim T2 LABS',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 250,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 2, categories.LAB * categories.LAND}},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.LAB} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 8, categories.LAB} },
            { EBC, 'LessThanEconStorageRatio', { 0.25, 1.1}},    
            { EBC, 'LessEconStorageCurrent', { 100, 1000 } },
        },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'LAB LAND'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim T1 PLANTS AIR',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 275,
        InstanceCount = 8,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.PLANT * categories.AIR}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.PLANT * categories.AIR} },
            { EBC, 'LessThanEconStorageRatio', { 0.2, 1.1}},    
        },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'PLANT AIR'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim T1 PLANTS LAND',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 300,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.PLANT}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, categories.LAB} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.PLANT} },
            { EBC, 'LessThanEconStorageRatio', { 0.2, 1.1}},    
        },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'PLANT'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 100,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.SOLAR}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.FUSION} },
            { EBC, 'LessThanEconStorageRatio', { 0.25, 1}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'SOLAR'},
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
}       