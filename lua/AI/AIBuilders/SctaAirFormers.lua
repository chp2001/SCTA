local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')

BuilderGroup {
    BuilderGroupName = 'SCTAAIAirFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI Air Scout',
        PlatoonTemplate = 'T1AirScoutFormSCTA',
        PriorityFunction = TAPrior.UnitProductionT1AIR,
        Priority = 100,
        InstanceCount = 10,
        BuilderType = 'Scout',
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.SCOUT * categories.AIR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Radar T3 Scout',
        PlatoonTemplate = 'SCTAT3AirScouting',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 125,
        InstanceCount = 10,
        BuilderType = 'Scout',
        BuilderConditions = {
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.OVERLAYOMNI * categories.AIR * categories.MOBILE} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Bomber Attack',
        PlatoonTemplate = 'SCTABomberAttack',
        PriorityFunction = TAPrior.UnitProductionT1AIR,
        Priority = 100,
        FormRadius = 500,
        InstanceCount = 5,
        BuilderType = 'Scout',        
        BuilderConditions = { 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 0, categories.BOMBER} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept',
        PlatoonTemplate = 'IntieAISCTA',
        PriorityFunction = TAPrior.UnitProductionT1AIR,
        Priority = 100,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        InstanceCount = 5,
        BuilderType = 'AirForm',     
        BuilderConditions = { 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 4, categories.ANTIAIR * categories.MOBILE * categories.AIR - categories.BOMBER } },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept Stealth',
        PlatoonTemplate = 'IntieAISCTAStealth',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 110,
        InstanceCount = 5,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        BuilderType = 'AirForm',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.AIR * (((categories.ANTIAIR + categories.GROUNDATTACK) * categories.TECH2) + categories.BOMBER)} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept Omni',
        PlatoonTemplate = 'IntieAISCTAALL',
        PriorityFunction = TAPrior.GantryConstruction,
        Priority = 110,
        InstanceCount = 10,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        BuilderType = 'AirForm',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
            { UCBC, 'HaveGreaterThanUnitsWithCategory', { 2, categories.ANTIAIR * categories.MOBILE * categories.AIR - categories.BOMBER } },
        },
    },
}