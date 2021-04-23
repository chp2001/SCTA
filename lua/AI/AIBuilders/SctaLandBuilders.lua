local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local Factory = import('/lua/editor/UnitCountBuildConditions.lua').HaveGreaterThanUnitsWithCategory
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)


local LandProductionT3 = function(self, aiBrain, builderManager)
    if Factory(aiBrain,  6, LAB)  then 
        return 130
    elseif Factory(aiBrain,  0, categories.GATE) then
        return 135
    else
        return 0
    end
end

BuilderGroup {
    BuilderGroupName = 'SCTAAILandBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory Tank Early',
        PlatoonTemplate = 'T1LandDFTankSCTAEarly',
        Priority = 92,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank',
        PlatoonTemplate = 'T1LandDFTankSCTA',
        Priority = 100,
            BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {300} },
            { UCBC, 'HaveUnitRatio', { 0.8, categories.LAND * categories.DIRECTFIRE * categories.MOBILE,
            '<', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery',
        PlatoonTemplate = 'T1LandArtillerySCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.MOBILE * categories.ARTILLERY,
            '<', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
         },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Artillery-AntiAir',
        PlatoonTemplate = 'T1LandAntiArtySCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.MOBILE * ((categories.ARTILLERY * categories.CORE) + (categories.ANTIAIR * categories.ARM)),
            '<', categories.LAND * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
         },
        BuilderType = 'Land',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank',
        PlatoonTemplate = 'T2LandDFTankSCTA',
        Priority = 120,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.6, categories.LAND * categories.TECH2 * categories.DIRECTFIRE - categories.SCOUT,
            '<=', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery',
        PlatoonTemplate = 'T2LandRocketSCTA',
        Priority = 100,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.TECH2 * categories.SILO,
            '<=', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } }, 
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir',
        PlatoonTemplate = 'T2LandAASCTA',
        Priority = 105,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
            '<', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.2, 0.25}},
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter',
        PlatoonTemplate = 'T2LandAuxFact1',
        Priority = 100,
        InstanceCount = 1,
        BuilderConditions = { 
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.BOMB * categories.LAND} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.25}},
        }, 
        BuilderType = 'KBot',
    },
    ---VEHICLE
    Builder {
        BuilderName = 'SCTAAi Factory Tank2 Early',
        PlatoonTemplate = 'T1LandDFTankSCTA2Early',
        Priority = 92,
        BuilderConditions = {
            { MIBC, 'LessThanGameTime', {300} }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Tank2',
        PlatoonTemplate = 'T1LandDFTankSCTA2',
        Priority = 100,
        BuilderConditions = {
        { MIBC, 'GreaterThanGameTime', {300} },
        { UCBC, 'HaveUnitRatio', { 0.8, categories.LAND * categories.DIRECTFIRE * categories.MOBILE,
        '<', categories.LAND * categories.MOBILE - categories.ENGINEER } },
        { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory2 AntiAir',
        PlatoonTemplate = 'T1LandAASCTA2',
        Priority = 90,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE,
                                       '<', categories.LAND  * categories.MOBILE - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Artillery2',
        PlatoonTemplate = 'T2LandMissileSCTA2',
        Priority = 100,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.TECH2 * categories.SILO * categories.MOBILE - categories.ANTIAIR,
            '<=', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 Tank2',
        PlatoonTemplate = 'T2LandDFTank2SCTA',
        Priority = 120,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.6, categories.LAND * categories.TECH2 * categories.DIRECTFIRE - categories.SCOUT,
            '<=', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } },
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Counter2',
        PlatoonTemplate = 'T2LandAuxFact2',
        Priority = 100,
        InstanceCount = 1,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.STEALTHFIELD * categories.LAND * categories.TECH2} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.25}},
        }, 
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi Factory Terrain T2',
        PlatoonTemplate = 'T2LandAuxTerrain2',
        Priority = 110,
        InstanceCount = 1,
        BuilderConditions = {   
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.AMPHIBIOUS * categories.LAND * categories.TECH2 * categories.DIRECTFIRE} },
            { EBC, 'GreaterThanEconStorageRatio', { 0.1, 0.25}},
        }, 
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT2 AntiAir2',
        PlatoonTemplate = 'T2LandAASCTA2',
        Priority = 100,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.2, categories.LAND * categories.ANTIAIR * categories.MOBILE * categories.TECH2,
            '<', categories.LAND * categories.MOBILE * categories.TECH2 - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Vehicle',
    },
----TECH3Things
    Builder {
    BuilderName = 'SCTAAi FactoryT3 Tank',
    PlatoonTemplate = 'T3LandDFTankSCTA',
    Priority = 139,
    PriorityFunction = LandProductionT3,
    InstanceCount = 2,
    BuilderConditions = {
        { UCBC, 'HaveUnitRatio', { 0.6, categories.LAND * categories.TECH3 * categories.DIRECTFIRE - categories.SCOUT,
                                   '<=', categories.LAND * categories.MOBILE * categories.TECH3 - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
        { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
    },
    BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Bot',
        PlatoonTemplate = 'T3LandDFBotSCTA',
        Priority = 130,
        PriorityFunction = LandProductionT3,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.LAND * categories.TECH3 * categories.BOT * 
            ((categories.SNIPER * categories.ARM) + (categories.ARTILLERY * categories.CORE))}}, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'KBot',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Vehicle',
        PlatoonTemplate = 'T3LandDFVehicleSCTA',
        Priority = 130,
        PriorityFunction = LandProductionT3,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 4, categories.LAND * categories.TECH3 * categories.TANK * 
            (((categories.SNIPER + categories.ARTILLERY) * categories.ARM) + (categories.ARTILLERY * categories.CORE))}}, -- Don't make tanks if we have lots of them.
            { EBC, 'GreaterThanEconStorageRatio', { 0.25, 0.15}},
        },
        BuilderType = 'Vehicle',
    },
    Builder {
        BuilderName = 'SCTAAi FactoryT3 Tank2',
        PlatoonTemplate = 'T3LandDFTank2SCTA',
        Priority = 130,
        PriorityFunction = LandProductionT3,
        InstanceCount = 2,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.6, categories.LAND * categories.TECH3 * categories.DIRECTFIRE - categories.SCOUT,
            '<=', categories.LAND * categories.MOBILE * categories.TECH3 - categories.ENGINEER } }, -- Don't make tanks if we have lots of them.
            { TAutils, 'EcoManagementTA', { 0.9, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'Vehicle',
    },
}

----needFigureOutMassEco and KnowingHowPauseFactoriesForAi