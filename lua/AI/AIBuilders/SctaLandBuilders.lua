local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAILandBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Kbot Early',
        PlatoonTemplate = 'T1LandDFTankSCTAEarly',
        Priority = 130,
BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Kbot',
        PlatoonTemplate = 'T1LandDFTankSCTA',
       PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 120,
BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Kbot Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA',
        Priority = 120,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.ARTILLERY} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
         },
        BuilderType = 'KBot',
    },
    ----VEHICLE T1
    Builder {
        BuilderName = 'SCTAAi Factory Tank Early',
        PlatoonTemplate = 'T1LandDFTankSCTA2Early',
        Priority = 130,
BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
       PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 120,
        DelayEqualBuildPlattons = {'FactoryProduction', 1},
        BuilderConditions = {
        { UCBC, 'CheckBuildPlattonDelay', { 'FactoryProduction' }},
        { MIBC, 'GreaterThanGameTime', {300} },
        { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank AntiAir',
        PlatoonTemplate = 'T1LandAASCTA2',
        Priority = 120,
        InstanceCount = 2,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    ----KBOT T2
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Kbot',
        PlatoonTemplate = 'T2LandDFTankSCTA',
        Priority = 125,
BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Kbot Artillery',
        PlatoonTemplate = 'T2LandRocketSCTA',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.SILO - categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Kbot AntiAir',
        PlatoonTemplate = 'T2LandAASCTA',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Kbot Counter',
        PlatoonTemplate = 'T2LandAuxFact1',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = { 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.BOMB} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        }, 
        BuilderType = 'KBot',
    },
    ---VEHICLE T2
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank',
        PlatoonTemplate = 'T2LandDFTank2SCTA',
        Priority = 125,
BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter Tank',
        PlatoonTemplate = 'T2LandAuxFact2',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.STEALTHFIELD * categories.LAND * categories.TECH2} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        }, 
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory All Tank Terrain T2',
        PlatoonTemplate = 'T2LandAuxTerrain2',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {   
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.TANK * categories.AMPHIBIOUS - categories.SCOUT} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        }, 
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir Tank',
        PlatoonTemplate = 'T2LandAASCTA2',
        Priority = 125,
        InstanceCount = 2,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery Tank',
        PlatoonTemplate = 'T2LandMissileSCTA2',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.SILO - categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
---GENERIC KBOT/VEHICLE
    Builder {
        BuilderName = 'SCTAAi Factory All Terrain Other',
        PlatoonTemplate = 'T2LandAuxTerrain',
        Priority = 125,
        InstanceCount = 1,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {(categories.SCOUT + categories.ARTILLERY) * (categories.HOVER + categories.AMPHIBIOUS)} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        }, 
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery-AntiAir',
        PlatoonTemplate = 'T1LandAntiArtySCTA',
        Priority = 125,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.ARTILLERY + categories.ANTIAIR} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
         },
        BuilderType = 'Land',
    },
----TECH3Things
    Builder {
    BuilderName = 'SCTAAi FactoryT3 KBot',
    PlatoonTemplate = 'T3LandDFTankSCTA',
    Priority = 150,
    PriorityFunction = TAPrior.ProductionT3,
    InstanceCount = 1,
    DelayEqualBuildPlattons = {'FactoryProduction', 1},
BuilderConditions = {
    { UCBC, 'CheckBuildPlattonDelay', { 'FactoryProduction' }},
        { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
    },
    BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Bot Sniper',
        PlatoonTemplate = 'T3LandDFBotSCTA',
        Priority = 100,
        PriorityFunction = TAPrior.ProductionT3,
        InstanceCount = 1,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.SNIPER + categories.ARTILLERY} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Vehicle Artillery',
        PlatoonTemplate = 'T3LandDFVehicleSCTA',
        Priority = 100,
        InstanceCount = 1,
        PriorityFunction = TAPrior.ProductionT3,
BuilderConditions = {
            { TASlow, 'TAHaveUnitRatioGreaterThanLand', {categories.SNIPER + categories.ARTILLERY} },
            { TAutils, 'EcoManagementTA', { 0.75, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank Vehicle',
        PlatoonTemplate = 'T3LandDFTank2SCTA',
        Priority = 150,
        PriorityFunction = TAPrior.ProductionT3,
        InstanceCount = 1,
BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.75, 0.5} },
        },
        BuilderType = 'Vehicle',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi

