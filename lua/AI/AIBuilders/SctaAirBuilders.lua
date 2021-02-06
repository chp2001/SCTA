local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIAirBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAI T1 Scouts',
        PlatoonTemplate = 'T1AirScoutSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.AIR } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 3, categories.MOBILE * categories.AIR * categories.SCOUT } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.3}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Bomber',
        PlatoonTemplate = 'T1AirBomberSCTA',
        Priority = 80,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.7}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Intie',
        PlatoonTemplate = 'T1AirFighterSCTA',
        Priority = 90,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.FACTORY * categories.LEVEL2 * categories.AIR } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.7}},
        },
        BuilderType = 'All',
    },        
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer',
        PlatoonTemplate = 'T1BuildEngineerAirSCTA',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER * categories.AIR * categories.LEVEL1} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Strategic',
        PlatoonTemplate = 'T2AirBomberSCTA',
        Priority = 85,
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.7}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Stealth',
        PlatoonTemplate = 'T2AirFighterSCTA',
        Priority = 95,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.7}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer2',
        PlatoonTemplate = 'T2BuildEngineerAirSCTA',
        Priority = 100, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER * categories.AIR * categories.LEVEL2} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    }, 
    Builder {
        BuilderName = 'SCTAAI T2 Scouts',
        PlatoonTemplate = 'T2AirScoutSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.JAM * categories.AIR * categories.SCOUT } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.3}},
        },
        BuilderType = 'All',
    },
    Builder {
        BuilderName = 'SCTAAi AirFactory Engineer3',
        PlatoonTemplate = 'T3BuildEngineerAirSCTA',
        Priority = 120, -- Top factory priority
        BuilderConditions = {
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.5}},
            { MIBC, 'GreaterThanGameTime', {1500} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.ENGINEER * categories.AIR * categories.LEVEL3} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'All',
    },     
    Builder {
        BuilderName = 'SCTAAI Factory Seaplane',
        PlatoonTemplate = 'T3AirFighterSCTA',
        Priority = 100,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'All',
    },
}