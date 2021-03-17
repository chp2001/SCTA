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
        BuilderName = 'SCTAAi Factory Scout',
        PlatoonTemplate = 'T1LandScoutSCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.SCOUT} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank Early',
        PlatoonTemplate = 'T1LandDFTankSCTAEarly',
        Priority = 90,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA',
        Priority = 95,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.5}}
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank2 Early',
        PlatoonTemplate = 'T1LandDFTankSCTA2Early',
        Priority = 90,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank2',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
        Priority = 95,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.5}}
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA',
        Priority = 70,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.MOBILE * categories.ARTILLERY,
            '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
         },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory AntiAir',
        PlatoonTemplate = 'T1LandAASCTA',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.LAB * categories.LAND } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA2',
        Priority = 70,
        BuilderConditions = { 
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.MOBILE * (categories.ARTILLERY + categories.ROCKET),
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank',
        PlatoonTemplate = 'T2LandDFTankSCTA',
        Priority = 105,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LAND * categories.LEVEL2 * categories.TANK,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.75 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}}
        },
        BuilderType = 'Land',
    },
    
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank2',
        PlatoonTemplate = 'T2LandDFTank2SCTA',
        Priority = 105,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LAND * categories.LEVEL2 * categories.TANK,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.75 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.5}}
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery',
        PlatoonTemplate = 'T2LandRocketSCTA',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.LEVEL2 * categories.ROCKET,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery2',
        PlatoonTemplate = 'T2LandMissileSCTA2',
        Priority = 85,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.LEVEL2 * categories.ROCKET,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter',
        PlatoonTemplate = 'T2LandAuxFact1',
        Priority = 70,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.TACLOAK * categories.LAND} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        }, 
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter2',
        PlatoonTemplate = 'T2LandAuxFact2',
        Priority = 70,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.JAM * categories.LAND} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        }, 
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir',
        PlatoonTemplate = 'T2LandAASCTA',
        Priority = 95,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, 
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
            '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir',
        PlatoonTemplate = 'T2LandAASCTA2',
        Priority = 85,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, 
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
            '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi T2 Experimental',
        PlatoonTemplate = 'SCTAExperimental',
        Priority = 130,
        BuilderConditions = {
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.75 } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.75}},
        },
        BuilderType = 'Gate',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Hover',
        PlatoonTemplate = 'T3LandHOVERSCTA',
        Priority = 140,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LAND * categories.TANK * categories.LEVEL3,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Artillery',
        PlatoonTemplate = 'T3HOVERMISSILESCTA', 
        Priority = 110,
        BuilderConditions = {
        { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.LEVEL3 * categories.ROCKET,
        '<=', categories.MOBILE * categories.LAND - categories.ENGINEER } }, -- Don't make tanks if we have lots of them. },
        },
        BuilderType = 'Land',
    },

    Builder {
        BuilderName = 'SCTAAi FactoryT3 AntiAir',
        PlatoonTemplate = 'THOVERAASCTA',
        Priority = 115,
        BuilderConditions = {
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } }, -- Build AA if the enemy is threatening our base with air units.
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank',
        PlatoonTemplate = 'T3LandDFTankSCTA',
        Priority = 130,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LEVEL3 * categories.TANK,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank3',
        PlatoonTemplate = 'T3LandDFTank2SCTA',
        Priority = 125,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LAND * categories.LEVEL3 * categories.TANK,
            '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 } },
        },
        BuilderType = 'Land',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi