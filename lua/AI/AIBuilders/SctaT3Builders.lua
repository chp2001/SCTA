local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAIT3Builder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi FactoryT3 HoverTank',
        PlatoonTemplate = 'T3LandHOVERSCTA',
        Priority = 138,
        PriorityFunction = TAPrior.LandProductionT3Tank,
        BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Hover',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Hover Artillery',
        PlatoonTemplate = 'T3HOVERMISSILESCTA', 
        Priority = 126,
        PriorityFunction = TAPrior.ProductionT3,
        BuilderConditions = {
        { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
    },
        BuilderType = 'Hover',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Hover AntiAir',
        PlatoonTemplate = 'T3HOVERAASCTA',
        Priority = 133,
        PriorityFunction = TAPrior.ProductionT3,
        BuilderConditions = {
         { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Hover',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Seaplane Fighter',
        PlatoonTemplate = 'T3AirFighterSCTA',
        Priority = 140,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { TAutils, 'EcoManagementTA', { 0.75, 0.9, 0.5, 0.5, } },
        },
        BuilderType = 'Seaplane',
    },
}