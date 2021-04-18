local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local TAutils = '/mods/SCTA-master/lua/AI/TAEditors/TAAIInstantConditions.lua'
local PLANT = (categories.FACTORY * categories.TECH1)
local LAB = (categories.FACTORY * categories.TECH2)
local PLATFORM = (categories.FACTORY * categories.TECH3)
local FUSION = (categories.ENERGYPRODUCTION * (categories.TECH2 + categories.TECH3)) * categories.STRUCTURE
local Interception = import('/lua/editor/UnitCountBuildConditions.lua').HaveLessThanUnitsWithCategory

local AirProduction = function(self, aiBrain, builderManager)
    if Interception(aiBrain,  1, (LAB * categories.AIR)) then 
        return 100
    else
        return 0
    end
end

BuilderGroup {
    BuilderGroupName = 'SCTAAIAirBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAI Factory Bomber',
        PlatoonTemplate = 'T1AirBomberSCTA',
        Priority = 85,
        BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.2, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Strategic',
        PlatoonTemplate = 'T2AirBomberSCTA',
        Priority = 110,
        BuilderConditions = {
            { TAutils, 'EcoManagementTA', { 0.2, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Intie',
        PlatoonTemplate = 'T1AirFighterSCTA',
        PriorityFunction = AirProduction,
        Priority = 95,
        BuilderConditions = { -- Only make inties if the enemy air is strong
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE, 'Enemy'}},		
        { TAutils, 'EcoManagementTA', { 0.2, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },       
    Builder {
        BuilderName = 'SCTAAI Factory Stealth',
        PlatoonTemplate = 'T2AirFighterSCTA',
        Priority = 115,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE, 'Enemy'}},
        { TAutils, 'EcoManagementTA', { 0.2, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAI Factory Seaplane Fighter',
        PlatoonTemplate = 'T3AirFighterSCTA',
        Priority = 100,
        BuilderConditions = { -- Only make inties if the enemy air is strong.
        { UCBC, 'HaveUnitsWithCategoryAndAlliance', { true, 0, categories.AIR * categories.MOBILE, 'Enemy'}},
        { TAutils, 'EcoManagementTA', { 0.2, 0.7, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },
    Builder {
        BuilderName = 'SCTAAirTransport',
        PlatoonTemplate = 'SCTATransport',
        Priority = 80,
        DelayEqualBuildPlattons = {'Transport', 3},
        BuilderConditions = {
            { UCBC, 'CheckBuildPlattonDelay', { 'Transport' }},
            { MIBC, 'GreaterThanGameTime', {900} },
            { MIBC, 'ArmyNeedsTransports', {} },
            { UCBC, 'LocationFactoriesBuildingLess', { 'LocationType', 2, 'TRANSPORTFOCUS' } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 6, 'TRANSPORTFOCUS' } },
            { UCBC, 'HaveLessThanUnitsInCategoryBeingBuilt', { 2, 'TRANSPORTFOCUS' } },
            { TAutils, 'EcoManagementTA', { 0.5, 0.9, 0.2, 0.5, } },
        },
        BuilderType = 'Air',
    },     
}