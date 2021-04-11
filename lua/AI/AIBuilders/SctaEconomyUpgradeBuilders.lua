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
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE


BuilderGroup {
    BuilderGroupName = 'SCTAUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'TAExtractorUpgrade',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        InstanceCount = 1,
        Priority = 150,
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA', { 'TAExtractors' }},
            { MIBC, 'GreaterThanGameTime', { 360 } },
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 1, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 }},
        },
        FormRadius = 1000,
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
        }
    },
    Builder {
        BuilderName = 'SCTAExtractorUpgradeTime',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        InstanceCount = 1,
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        Priority = 100,
        BuilderConditions = {
            { TASlow, 'CheckBuildPlatoonDelaySCTA',  { 'TAExtractors' }},
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 2, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconIncome',  { 6, 70}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 0.75 }},
        },
        FormRadius = 500,
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
        }
    },
    Builder {
        BuilderName = 'SCTA Extractor Emergency Upgrade',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        DelayEqualBuildPlattons = {'TAExtractorUpgrade', 1},
        InstanceCount = 2,
        Priority = 150,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 480 } },
            { TASlow, 'CheckBuildPlatoonDelaySCTA',  { 'TAExtractors' }},
            { TASlow, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 3, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconStorageRatio', { 0.5, 0.5}},
            { EBC, 'GreaterThanEconStorageCurrent', { 800, 1000 } },
        },
        FormRadius = 500,
        BuilderType = 'Any',
        BuilderData = {
            NeedGuard = false,
            DesiresAssist = true,
            NumAssistees = 2,
        }
    },
    Builder {
        BuilderName = 'SCTAUpgradeIntel',
        PlatoonTemplate = 'SctaIntelUpgrades',
        Priority = 50,
        InstanceCount = 1,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 1, categories.OPTICS} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.5 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.TECH2} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, FUSION} },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTAMetalMakr',
        PlatoonTemplate = 'FabricationSCTA',
        Priority = 300,
        InstanceCount = 3,
        BuilderConditions = {
                { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.MASSFABRICATION}},
            },
        BuilderType = 'Any',
        FormRadius = 10000,
    },
}