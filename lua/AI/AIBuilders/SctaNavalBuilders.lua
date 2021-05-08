local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAINavalBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Naval Engineer',
        PlatoonTemplate = 'T1EngineerSCTANaval',
        PriorityFunction = TAPrior.EngineerProduction,
        Priority = 140, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.NAVAL * categories.ENGINEER * categories.TECH1} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Naval2 Engineer',
        PlatoonTemplate = 'T2EngineerSCTANaval',
        Priority = 145, -- Top factory priority
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.NAVAL * categories.ENGINEER * categories.TECH2} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Hover Naval Engineer',
        PlatoonTemplate = 'T3BuildEngineerSCTA',
        Priority = 120, -- Top factory priority
        PriorityFunction = TAPrior.EngineerProductionT3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 * categories.HOVER} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'SpecHover',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Engineer Naval Air',
        PlatoonTemplate = 'T3BuildEngineerAirSCTA',
        Priority = 125, -- Top factory priority
        PriorityFunction = TAPrior.EngineerProductionT3,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.ENGINEER * categories.TECH3 * categories.AIR} }, -- Build engies until we have 4 of them.
        },
        BuilderType = 'SpecAir',
    },
    Builder {
        BuilderName = 'SCTAAi Factory ScoutShip',
        PlatoonTemplate = 'T1ScoutShipSCTA',
        PriorityFunction = TAPrior.AirProduction,
        Priority = 110,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.SCOUT * categories.NAVAL } },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Hover',
        PlatoonTemplate = 'T1ScoutShipSCTA',
        Priority = 115,
        BuilderConditions = {
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 8, categories.SCOUT * categories.NAVAL } },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.xsl0103 + categories.ual0201, 'Enemy'}},	
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT1 AntiSub',
        PlatoonTemplate = 'T1SubSCTA',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 120,
        BuilderConditions = {
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.SUBMERSIBLE - categories.ENGINEER} },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.SUBMERSIBLE * categories.MOBILE, 'Enemy'}},	
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiSub',
        PlatoonTemplate = 'T2SubSCTA',
        Priority = 115,
        BuilderConditions = {
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.SUBMERSIBLE - categories.ENGINEER} },
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.SUBMERSIBLE * categories.MOBILE, 'Enemy'}},
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Frigate Naval',
        PlatoonTemplate = 'T1FrigateSCTA',
        Priority = 120,
        BuilderConditions = {
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, (categories.NAVAL * categories.FACTORY), 'Enemy'}},	
            { UCBC, 'HaveUnitRatio', { 0.33, categories.NAVAL * categories.MOBILE * categories.FRIGATE,
            '<=', categories.NAVAL * categories.MOBILE} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } }, -- Stop after 10 facs have been built.
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Destroyer Naval',
        PlatoonTemplate = 'T2DestroyerSCTA',
        Priority = 126,
        BuilderConditions = {
            { TASlow,   'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},		
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, categories.DESTROYER} }, -- Build engies until we have 4 of them.
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi AntiAir Naval',
        PlatoonTemplate = 'T2CrusSCTA',
        Priority = 125,
        BuilderConditions = {
            { TASlow,    'TAAttackNaval', {true}},
            { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.NAVAL * categories.FACTORY, 'Enemy'}},	
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.CRUISER} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Battleship',
        PlatoonTemplate = 'BattleshipSCTA',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 131,
        BuilderConditions = {
            { TASlow,    'TAAttackNaval', {true}},
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.BATTLESHIP } }, -- Stop after 10 facs have been built.
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'Sea',
    },
}
