
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


BuilderGroup {
    BuilderGroupName = 'SCTAAssisters',
    BuildersType = 'PlatoonFormBuilder',
    ----Building Reclaim
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Excess PLANTS',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 100,
        InstanceCount = 5,
        BuilderConditions = {
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, PLANT}},
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 3, LAB * categories.LAND} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, LAB * categories.AIR} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, PLANT} },
            { TAutils, 'LessMassStorageMaxTA', { 0.2}},    
            },
        BuilderData = {
            Location = 'LocationType',
            ReclaimTime = 30,
            Reclaim = {'TECH1 FACTORY,'},
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Energy',
        PlatoonTemplate = 'EngineerBuilderSCTAALL',
        PlatoonAIPlan = 'ReclaimStructuresAI',
        Priority = 85,
        InstanceCount = 4,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, FUSION} },
            { UCBC, 'UnitsGreaterAtLocation', { 'LocationType', 0, WIND + SOLAR}},
            { TAutils, 'LessMassStorageMaxTA',  { 0.2}},
            },
        BuilderData = {
            Location = 'LocationType',
            Reclaim = {'armsolar, corsolar, armwin, corwin,'},
                ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Air',
        PlatoonTemplate = 'EngineerBuilderSCTAEco',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 125,
        InstanceCount = 5,
        BuilderConditions = {
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},
            },
        BuilderData = {
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Engineer Reclaim Idle',
        PlatoonTemplate = 'EngineerBuilderSCTA',
        PlatoonAIPlan = 'SCTAReclaimAI',
        Priority = 125,
        InstanceCount = 2,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 240 } },
            { TASlow, 'TAReclaimablesInArea', { 'LocationType', }},  
        },
        BuilderData = {
            Terrain = true,
            LocationType = 'LocationType',
            ReclaimTime = 30,
        },
        BuilderType = 'Any',
    },
}

--[[]]