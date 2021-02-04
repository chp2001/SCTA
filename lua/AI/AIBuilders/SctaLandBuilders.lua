local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAILandBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory BOT',
        PlatoonTemplate = 'T1LandDFBotSCTA',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        Priority = 90,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Engineer',
        PlatoonTemplate = 'T1BuildEngineerSCTA',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER - categories.COMMAND } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Scout',
        PlatoonTemplate = 'T1LandScoutSCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.MOBILE * categories.LAND } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA',
        Priority = 90,
        BuilderConditions = {
            {  UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.TANK } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA',
        Priority = 70,
        BuilderConditions = { },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory AntiAir',
        PlatoonTemplate = 'T1LandAASCTA',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, -- Build AA if the enemy is threatening our base with air units.
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 BOT',
        PlatoonTemplate = 'T1LandDFBotSCTA2',
        PlatoonAddFunctions = { {SAI, 'BuildOnce'}, },
        Priority = 95,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Scout',
        PlatoonTemplate = 'T1LandScoutSCTA2',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 10, categories.MOBILE * categories.LAND } },
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
        Priority = 90,
        BuilderConditions = {
            {  UCBC, 'HaveLessThanUnitsWithCategory', { 20, categories.TANK } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA2',
        Priority = 70,
        BuilderConditions = { },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 AntiAir',
        PlatoonTemplate = 'T1LandAASCTA2',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, -- Build AA if the enemy is threatening our base with air units.
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'All',
    },
}