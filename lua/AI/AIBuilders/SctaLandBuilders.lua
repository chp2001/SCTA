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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.SCOUT * categories.LAND } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.TANK,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.SCOUT * categories.LAND } },
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.TANK,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
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
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerSCTA',
        Priority = 110, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.ENGINEER * categories.LEVEL2 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank',
        PlatoonTemplate = 'T2LandDFTankSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL2 * categories.DIRECTFIRE,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery',
        PlatoonTemplate = 'T2LandMissileSCTA',
        Priority = 85,
        BuilderConditions = { },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory AntiAir',
        PlatoonTemplate = 'T2LandAASCTA',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, -- Build AA if the enemy is threatening our base with air units.
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Experimental',
        PlatoonTemplate = 'SCTAExperimental',
        Priority = 130,
        BuilderConditions = {},
        BuilderType = 'All',
    },
}

