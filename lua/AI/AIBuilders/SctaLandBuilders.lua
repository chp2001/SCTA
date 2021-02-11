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
        Priority = 110,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {150} }, -- Don't make tanks if we have lots of them.
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
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.LAND } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT} },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.TANK,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA',
        Priority = 70,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
         },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory AntiAir',
        PlatoonTemplate = 'T1LandAASCTA',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.LAND } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 BOT',
        PlatoonTemplate = 'T1LandDFBotSCTA2',
        Priority = 110,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {150} }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.TANK,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FACTORY * categories.LEVEL2 * categories.LAND } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA2',
        Priority = 70,
        BuilderConditions = { 
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 AntiAir',
        PlatoonTemplate = 'T1LandAASCTA2',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
            '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT2 Engineer',
        PlatoonTemplate = 'T2BuildEngineerSCTA',
        Priority = 110, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.LEVEL2 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Field Engineer',
        PlatoonTemplate = 'T2BuildFieldEngineerSCTA',
        Priority = 95, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.FIELDENGINEER * categories.LEVEL2} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer',
        PlatoonTemplate = 'T3BuildEngineerSCTA',
        Priority = 125, -- Top factory priority
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 5, categories.ENGINEER * categories.LEVEL3 - categories.FIELDENGINEER } }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank',
        PlatoonTemplate = 'T2LandDFTankSCTA',
        Priority = 100,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL2 * categories.DIRECTFIRE,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank2',
        PlatoonTemplate = 'T2LandDFTank2SCTA',
        Priority = 100,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL2 * categories.DIRECTFIRE,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery',
        PlatoonTemplate = 'T2LandMissileSCTA',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LEVEL2 * categories.ROCKET,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
         },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter',
        PlatoonTemplate = 'T2LandAuxFact1',
        Priority = 70,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.JAM * categories.LEVEL2 * categories.LAND} },
        }, 
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi Factory2 Counter',
        PlatoonTemplate = 'T2LandAuxFact2',
        Priority = 70,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.JAM * categories.LEVEL2 * categories.LAND} },
        }, 
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir',
        PlatoonTemplate = 'T2LandAASCTA',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
            '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi T2 Experimental',
        PlatoonTemplate = 'SCTAExperimental',
        Priority = 130,
        BuilderConditions = {},
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Hover',
        PlatoonTemplate = 'T3LandHOVERSCTA',
        Priority = 90,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
            { UCBC, 'HaveUnitRatio', { 0.65, categories.TANK,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Artillery',
        PlatoonTemplate = 'T3HOVERMISSILESCTA', 
        Priority = 70,
        BuilderConditions = {
        { UCBC, 'HaveUnitRatio', { 0.2, categories.LEVEL3 * categories.ROCKET,
        '<=', categories.LEVEL3 * categories.LAND - categories.ENGINEER } }, -- Don't make tanks if we have lots of them. },
        },
        BuilderType = 'All',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT3 AntiAir',
        PlatoonTemplate = 'THOVERAASCTA',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, -- Build AA if the enemy is threatening our base with air units.
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank',
        PlatoonTemplate = 'T3LandDFTankSCTA',
        Priority = 125,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1300} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL3 * categories.DIRECTFIRE,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank3',
        PlatoonTemplate = 'T3LandDFTank2SCTA',
        Priority = 125,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1300} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.5}},
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL3 * categories.DIRECTFIRE,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        },
        BuilderType = 'All',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi