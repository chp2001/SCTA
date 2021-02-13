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

BuilderGroup {
    BuilderGroupName = 'SctaExtractorUpgrades',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'SCTA Extractor Upgrade',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 1,
        Priority = 200,
        BuilderConditions = {
            { EBC, 'GreaterThanEconIncome',  { 4, 50}},
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.5, 1.2 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.MASSEXTRACTION * categories.LEVEL2} },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTA Extractor Upgrade Time Based',
        PlatoonTemplate = 'T1MassExtractorUpgrade',
        InstanceCount = 2,
        Priority = 200,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', { 900 } },
            { EBC, 'GreaterThanEconStorageCurrent', { 600, 2000 } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 3, categories.MASSEXTRACTION * categories.LEVEL2} },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        FormRadius = 10000,
        BuilderType = 'Any',
    },
    Builder {
        BuilderName = 'SCTAUpgradeRadar',
        PlatoonTemplate = 'T1RadarUpgrade',
        Priority = 50,
        BuilderConditions = {
            { MIBC, 'GreaterThanGameTime', {1200} },
            { EBC, 'GreaterThanEconEfficiencyOverTime', { 0.9, 1.5 }},
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 1, categories.RADAR * categories.STRUCTURE * categories.LEVEL2} },
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.FUSION} },
            { IBC, 'BrainNotLowPowerMode', {} },
        },
        BuilderType = 'Any',
    },
}