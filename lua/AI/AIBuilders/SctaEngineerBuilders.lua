local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory


local EngineerProduction = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  6, LAB) then 
        return 0
    elseif Factory(aiBrain,  0, LAB) then 
        return 10
    else
        return 101
    end
end

local EngineerProductionT3 = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  12, LAB)  then 
        return 130
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 135
    else
        return 0
    end
end

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Scout',
        PlatoonTemplate = 'T1LandScoutSCTA',
        Priority = 82,
        PriorityFunction = EngineerProduction,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.LAND * categories.MOBILE} },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 Scout',
        PlatoonTemplate = 'T1LandScoutSCTA2',
        Priority = 80,
        PriorityFunction = EngineerProduction,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {360} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.LAND * categories.MOBILE} },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAI T1 Scouts',
        PlatoonTemplate = 'T1AirScoutSCTA',
        PriorityFunction = EngineerProduction,
        Priority = 110,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {900} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.AIR * categories.SCOUT } },
            { TAutils, 'EcoManagementTA', { 0.75, 1.05, 0.5, 0.5, } },
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAI T2 Scouts',
        PlatoonTemplate = 'T2AirScoutSCTA',
        Priority = 120,
        PriorityFunction = EngineerProductionT3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.MOBILE * categories.AIR * categories.SCOUT } },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAi Field Engineer',
        PlatoonTemplate = 'T2BuildFieldEngineerSCTA',
        Priority = 125, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FIELDENGINEER * categories.TECH2} }, -- Build engies until we have 4 of them.
        },
        BuilderType =  'Field',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Engineer',
        PlatoonTemplate = 'T1BuildEngineerSCTA',
        Priority = 100, -- Top factory priority
        PriorityFunction = EngineerProduction,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.LAND * categories.TECH1 - categories.COMMAND } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType =  'Field',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Engineer Early',
        PlatoonTemplate = 'T1BuildEngineerSCTAEarly',
        Priority = 150, -- Top factory priority
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {60} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType =  'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerSCTA',
        Priority = 110, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2 * categories.LAND - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType =  'Land',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer',
        PlatoonTemplate = 'T1BuildEngineerAirSCTA',
        Priority = 105,
        PriorityFunction = EngineerProduction,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER * categories.AIR * categories.TECH1} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerAirSCTA',
        Priority = 110,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, FUSION} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.AIR * categories.TECH2} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer',
        PlatoonTemplate = 'T3BuildEngineerSCTA',
        Priority = 120, -- Top factory priority
        PriorityFunction = EngineerProductionT3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 * categories.HOVER} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'SpecHover',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer Air',
        PlatoonTemplate = 'T3BuildEngineerAirSCTA',
        Priority = 125, -- Top factory priority
        PriorityFunction = EngineerProductionT3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 * categories.AIR} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'SpecAir',
    },
    Builder {
        BuilderName = 'SCTAAi T2 Experimental',
        PlatoonTemplate = 'SCTAExperimental',
        Priority = 120,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.EXPERIMENTAL * categories.MOBILE - categories.ENGINEER} },
        },
        BuilderType = 'Gate',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi