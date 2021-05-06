local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'
local TAPrior = import('/mods/SCTA-master/lua/AI/TAEditors/TAPriorityManager.lua')
local TASlow = '/mods/SCTA-master/lua/AI/TAEditors/TAAIUtils.lua'
local SKY = categories.AIR * categories.MOBILE
local STEALTH = categories.armhawk + categories.corvamp


BuilderGroup {
    BuilderGroupName = 'SCTAAIAirFormers',
    BuildersType = 'PlatoonFormBuilder', -- A PlatoonFormBuilder is for builder groups of units.
    Builder {
        BuilderName = 'SCTAAI Air Scout',
        PlatoonTemplate = 'T1AirScoutFormSCTA',
        Priority = 150,
        InstanceCount = 5,
        BuilderType = 'Scout',
        BuilderConditions = {
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, SKY * categories.SCOUT * categories.OVERLAYRADAR} },
         },
    },
    Builder {
        BuilderName = 'SCTAAI Bomber Attack',
        PlatoonTemplate = 'SCTABomberAttack',
        PlatoonAIPlan = 'BomberAISCTA',
        PriorityFunction = TAPrior.UnitProductionT1AIR,
        Priority = 100,
        InstanceCount = 20,
        BuilderType = 'AirForm',        
        BuilderConditions = { 
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, SKY * categories.BOMBER} },
            },
        },
    Builder {
        BuilderName = 'SCTAAI Air Intercept',
        PlatoonTemplate = 'IntieAISCTA',
        PlatoonAIPlan = 'InterceptorAISCTA',
        PriorityFunction = TAPrior.UnitProductionT1AIR,
        Priority = 100,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        InstanceCount = 20,
        BuilderType = 'AirForm',     
        BuilderConditions = { 
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, SKY * categories.ANTIAIR * categories.TECH1} },
        },
    },
    Builder {
        BuilderName = 'SCTAAI Air Intercept Stealth',
        PlatoonTemplate = 'SCTABomberAttack',
        PlatoonAIPlan = 'InterceptorAISCTAStealth',
        PriorityFunction = TAPrior.UnitProduction,
        Priority = 110,
        InstanceCount = 20,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        BuilderType = 'AirForm',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, SKY * (categories.BOMBER + categories.GROUNDATTACK) + STEALTH} },
            },
        },   
    Builder {
        BuilderName = 'SCTAAI Air Intercept Omni',
        PlatoonTemplate = 'IntieAISCTA',
        PlatoonAIPlan = 'InterceptorAISCTAEnd',
        PriorityFunction = TAPrior.GantryConstruction,
        Priority = 110,
        InstanceCount = 20,
        PlatoonAddBehaviors = { 'SCTAAirUnitRefit' },                              
        BuilderType = 'AirForm',
        BuilderData = {
            Energy = true,
        },        
        BuilderConditions = { 
            { TASlow, 'TAHaveGreaterThanArmyPoolWithCategory', { 1, SKY * categories.ANTIAIR - categories.BOMBER - categories.GROUNDATTACK} },
        },
    },
}