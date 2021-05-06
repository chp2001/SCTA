#***************************************************************************
#*
#**  File     :  /lua/ai/AIEconomyUpgradeBuilders.lua
#**
#**  Summary  : Default economic builders for skirmish
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'TAExtractorUpgrade',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        PriorityFunction = TAPrior.UnitProduction,
        InstanceCount = 1,
        Priority = 150,
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA', { 'TAExtractors' }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * categories.TECH1 } },
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 1, categories.MASSEXTRACTION * categories.TECH1 } },  
            { TAutils, 'EcoManagementTA', { 0.5, 0.5, 0.5, 0.5, } },
        },
        BuilderType = 'StructureForm',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
        }
    },
    Builder {
        BuilderName = 'SCTAExtractorUpgradeTime',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        PriorityFunction = TAPrior.StructureProductionT2,
        Priority = 100,
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA',  { 'TAExtractors' }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * categories.TECH1 } },
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 2, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconIncome',  { 8, 70}},
            { TAutils, 'EcoManagementTA', { 0.75, 0.75, 0.5, 0.5, } },
        },
        BuilderType = 'StructureForm',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
        }
    },
    Builder {
        BuilderName = 'SCTA Extractor Emergency Upgrade',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        PriorityFunction = TAPrior.FactoryReclaim,
        InstanceCount = 2,
        Priority = 150,
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA',  { 'TAExtractors' }},
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MASSEXTRACTION * categories.TECH1 } },
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 3, categories.MASSEXTRACTION * categories.TECH1 } },  
            { TAutils, 'EcoManagementTA', { 0.9, 0.9, 0.75, 0.75, } },
            { EBC, 'GreaterThanEconStorageCurrent', { 800, 1000 } },
        },
        BuilderType = 'StructureForm',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = false,
        }
    },
    Builder {
        BuilderName = 'SCTAUpgradeIntel',
        PlatoonTemplate = 'SctaIntelUpgrades',
        PriorityFunction = TAPrior.TechEnergyExist,
        Priority = 50,
        InstanceCount = 1,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OPTICS} },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.TECH2 - categories.FACTORY} },
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.RADAR * categories.STRUCTURE * categories.TECH1 - categories.FACTORY} },
            { TAutils, 'EcoManagementTA', { 0.75, 1.05, 0.5, 0.9, } },
        },
        BuilderType = 'StructureForm',
    },
    Builder {
        BuilderName = 'SCTAMetalMakr',
        PlatoonTemplate = 'FabricationSCTA',
        Priority = 300,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.MASSFABRICATION} },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSFABRICATION}},
            },
        BuilderType = 'StructureForm',
    },
    Builder {
        BuilderName = 'SCTAArtilleryAI',
        PlatoonTemplate = 'ArtillerySCTA',
        Priority = 300,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.ARTILLERY * categories.STRUCTURE} },
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.ARTILLERY * categories.STRUCTURE}},
            },
        BuilderType = 'StructureForm',
    },
    Builder {
        BuilderName = 'SCTAMiniNukeAI',
        PlatoonTemplate = 'TacticalMissileSCTA',
        Priority = 300,
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.TACTICALMISSILEPLATFORM * categories.STRUCTURE}},
            },
        BuilderType = 'StructureForm',
    },
}