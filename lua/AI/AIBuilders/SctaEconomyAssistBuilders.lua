
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
        BuilderName = 'SCTA Assist Gantry',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 60,
        InstanceCount = 12,
        BuilderConditions = {
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = categories.FACTORY,
                AssistRange = 120,
                BeingBuiltCategories = {categories.EXPERIMENTAL},                   
                PermanentAssist = true,
                AssistClosestUnit = false,                                       
                AssistUntilFinished = true,
                Time = 60,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Assist Gantry Production',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 75,
        InstanceCount = 12,
        BuilderConditions = {
        },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = categories.ENGINEER,
                AssistRange = 120,
                BeingBuiltCategories = {categories.EXPERIMENTAL},                   
                PermanentAssist = true,
                AssistClosestUnit = false,                                       
                AssistUntilFinished = true,
                Time = 60,
            },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Mex Assist',
        PlatoonTemplate = 'EngineerBuilderSCTAAssist',
        Priority = 75,
        InstanceCount = 2,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
        },
        BuilderType = 'Any',
        BuilderData = {
            Assist = {
                AssistUntilFinished = true,
                AssistLocation = 'LocationType',
                AssisteeType = categories.STRUCTURE,
                AssistRange = 100,
                AssistClosestUnit = true,
                BeingBuiltCategories = {categories.STRUCTURE * categories.MASSEXTRACTION * categories.LEVEL3},
                Time = 60,
            },
        }
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 75,
        InstanceCount = 3,
        BuilderConditions = {
                { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim2',
        PlatoonTemplate = 'EngineerBuilderSCTAField',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 75,
        InstanceCount = 3,
        BuilderConditions = {
                { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'ReclaimAI',
        Priority = 2,
        InstanceCount = 10,
        BuilderConditions = {
                { MIBC, 'ReclaimablesInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 200,
        InstanceCount = 5,
        BuilderConditions = {
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 1, categories.LEVEL3 * categories.FACTORY}},
                { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, categories.LEVEL1 * categories.PLANT }},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'LEVEL1 PLANT'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim T1 PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 300,
        InstanceCount = 8,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'LEVEL1 PLANT'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Finish',
        PlatoonTemplate = 'EngineerBuilderSCTA123',
        PlatoonAIPlan = 'ManagerEngineerFindUnfinished',
        Priority = 50,
        InstanceCount = 3,
        BuilderConditions = {
                { UCBC, 'UnfinishedUnits', { 'LocationType', categories.STRUCTURE}},
            },
        BuilderData = {
            Assist = {
                AssistLocation = 'LocationType',
                AssisteeType = 'Engineer',
                BeingBuiltCategories = {categories.STRATEGIC, categories.ECONOMIC, categories.STRUCTURE},
                Time = 20,
            },
        },
        BuilderType = 'Any',
    },
}       