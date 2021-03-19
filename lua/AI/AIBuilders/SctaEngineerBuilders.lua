local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local FUSION = categories.ENERGYPRODUCTION * categories.STRUCTURE * (categories.TECH2 + categories.TECH3)

BuilderGroup {
    BuilderGroupName = 'SCTAAIEngineerBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Engineer Early',
        PlatoonTemplate = 'T1BuildEngineerSCTAEarly',
        Priority = 150, -- Top factory priority
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {180} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerSCTA',
        Priority = 110, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH2 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
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
        },
        BuilderType = 'Air',
    }, 
    Builder {
        BuilderName = 'SCTAAi Factory Naval Engineer',
        PlatoonTemplate = 'T1EngineerSCTANaval',
        Priority = 120, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.OCEANENGINEER} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Engineer',
        PlatoonTemplate = 'T1BuildEngineerSCTA',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.ENGINEER * categories.LAND * categories.TECH1 - categories.COMMAND } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Field Engineer',
        PlatoonTemplate = 'T2BuildFieldEngineerSCTA',
        Priority = 95, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.FIELDENGINEER * categories.TECH2} }, -- Build engies until we have 4 of them.
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
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi