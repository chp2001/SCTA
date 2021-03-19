#***************************************************************************
#*
#**  File     :  /lua/ai/AIEconomyUpgradeBuilders.lua
#**
#**  Summary  : Default economic builders for skirmish
#**
#**  Copyright © 2005 Gas Powered Games, Inc.  All rights reserved.
#****************************************************************************

local BBTmplFile = '/lua/basetemplates.lua'
local BuildingTmpl = 'BuildingTemplates'
local BaseTmpl = 'BaseTemplates'
local ExBaseTmpl = 'ExpansionBaseTemplates'
local Adj2x2Tmpl = 'Adjacency2x2'
local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local MABC = '/lua/editor/MarkerBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local OAUBC = '/lua/editor/OtherArmyUnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local PCBC = '/lua/editor/PlatoonCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local PlatoonFile = '/lua/platoon.lua'
local TAutils = '/mods/SCTA-master/lua/TAutils.lua'
local FUSION = categories.ENERGYPRODUCTION * categories.STRUCTURE * (categories.TECH2 + categories.TECH3)

BuilderGroup {
    BuilderGroupName = 'SCTAUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'SCTA Extractor Upgrade',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        DelayEqualBuildPlattons = {'Mexupgrade1', 1},
        InstanceCount = 1,
        Priority = 150,
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Mexupgrade1' }},
            { MIBC, 'GreaterThanGameTime', { 360 } },
            { TAutils, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 1, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 0.5 }},
            { IBC, 'BrainNotLowPowerMode', {} },
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
        BuilderName = 'SCTA Extractor Upgrade Time Based',
        PlatoonTemplate = 'SctaExtractorUpgrades',
        InstanceCount = 2,
        Priority = 100,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 1200 } },
            { TAutils, 'HaveLessThanUnitsInCategoryBeingUpgradeSCTA', { 2, categories.MASSEXTRACTION * categories.TECH1 } },  
            { EBC, 'GreaterThanEconIncome',  { 6, 70}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.8, 0.75 }},
            { IBC, 'BrainNotLowPowerMode', {} },
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
                { EBC, 'LessThanEconStorageRatio',  { 1.1, 0.6}},
            },
        BuilderType = 'Any',
        FormRadius = 10000,
    },
}