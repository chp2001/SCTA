local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'

BuilderGroup {
    BuilderGroupName = 'SCTAAIT3Builder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi FactoryT3 HoverTank',
        PlatoonTemplate = 'T3LandHOVERSCTA',
        Priority = 138,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.65, categories.LAND * categories.DIRECTFIRE * categories.TECH3 - categories.SCOUT,
                                       '<=', categories.LAND * categories.MOBILE - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Artillery',
        PlatoonTemplate = 'T3HOVERMISSILESCTA', 
        Priority = 126,
        InstanceCount = 1,
        BuilderConditions = {
        { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.TECH3 * categories.SILO * categories.MOBILE,
        '<=', categories.MOBILE * categories.LAND - categories.ENGINEER } }, -- Don't make tanks if we have lots of them. },
        { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
    },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 AntiAir',
        PlatoonTemplate = 'THOVERAASCTA',
        Priority = 133,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.35, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
                                       { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
            { TBC, 'EnemyThreatGreaterThanValueAtBase', { 'LocationType', 0, 'Air', 1 } },
        },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Seaplane Fighter',
        PlatoonTemplate = 'T3AirFighterSCTA',
        Priority = 140,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE, 'Enemy'}},
        { TAutils, 'EcoManagementTA', { 0.2, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },
}