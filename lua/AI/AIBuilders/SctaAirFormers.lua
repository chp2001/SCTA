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
        Priority = 100,
        InstanceCount = 10,
        BuilderType = 'Air',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0,  categories.SCOUT * categories.TECH1 * categories.AIR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Radar T3 Scout',
        PlatoonTemplate = 'SCTAT3AirScouting',
        PriorityFunction = TAPrior.ProductionT3,
        Priority = 125,
        InstanceCount = 10,
        BuilderType = 'Air',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.OVERLAYOMNI * categories.AIR * categories.MOBILE} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Bomber Attack',
        PlatoonTemplate = 'SCTABomberAttack',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 100,
        FormRadius = 500,
        InstanceCount = 50,
        BuilderType = 'Air',        
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.BOMBER} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept',
        PlatoonTemplate = 'IntieAISCTA',
        PriorityFunction = TAPrior.UnitProductionT1,
        Priority = 100,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'AirUnitRefit' },                              
        InstanceCount = 200,
        BuilderType = 'Air',     
        BuilderConditions = { 
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept Stealth',
        PlatoonTemplate = 'IntieAISCTAStealth',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 110,
        InstanceCount = 25,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'AirUnitRefit' },                              
        BuilderType = 'Air',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 1, categories.AIR * (((categories.ANTIAIR + categories.GROUNDATTACK) * categories.TECH2) + categories.BOMBER)} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept Omni',
        PlatoonTemplate = 'IntieAISCTAALL',
        PriorityFunction = TAPrior.GantryConstruction,
        Priority = 110,
        InstanceCount = 200,
        FormRadius = 500,
        PlatoonAddBehaviors = { 'AirUnitRefit' },                              
        BuilderType = 'Air',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
        },
    },
}