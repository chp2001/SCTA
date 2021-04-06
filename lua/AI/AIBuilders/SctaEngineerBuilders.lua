local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Scout',
        PlatoonTemplate = 'T1LandScoutSCTA',
        Priority = 91,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {600} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.LAND * categories.MOBILE} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 Scout',
        PlatoonTemplate = 'T1LandScoutSCTA2',
        Priority = 93,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {180} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT * categories.LAND * categories.MOBILE} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAI T1 Scouts',
        PlatoonTemplate = 'T1AirScoutSCTA',
        Priority = 200,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.MOBILE * categories.AIR * categories.SCOUT } },
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAI T2 Scouts',
        PlatoonTemplate = 'T2AirScoutSCTA',
        Priority = 105,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.MOBILE * categories.AIR * categories.SCOUT } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.75, 1.05 }},
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAi Field Engineer',
        PlatoonTemplate = 'T2BuildFieldEngineerSCTA',
        Priority = 125, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FIELDENGINEER * categories.TECH2} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Engineer Early',
        PlatoonTemplate = 'T1BuildEngineerSCTAEarly',
        Priority = 150, -- Top factory priority
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {60} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerSCTA',
        Priority = 110, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3,  PLATFORM} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer',
        PlatoonTemplate = 'T1BuildEngineerAirSCTA',
        Priority = 105,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER * categories.AIR * categories.TECH1} }, -- Build engies until we have 4 of them.
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}}, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  LAB * categories.AIR} },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer2',
        PlatoonTemplate = 'T2BuildEngineerAirSCTA',
        Priority = 120,
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, FUSION} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.AIR * categories.TECH2} }, -- Build engies until we have 4 of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1,  PLATFORM * categories.AIR} },
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAi Factory Engineer',
        PlatoonTemplate = 'T1BuildEngineerSCTA',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.ENGINEER * categories.LAND * categories.TECH1 - categories.COMMAND } }, -- Don't make tanks if we have lots of them.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2,  LAB} },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer',
        PlatoonTemplate = 'T3BuildEngineerSCTA',
        Priority = 120, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer Air',
        PlatoonTemplate = 'T3BuildEngineerAirSCTA',
        Priority = 125, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 * categories.AIR - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Air',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi