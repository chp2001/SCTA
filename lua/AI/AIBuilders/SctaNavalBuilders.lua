local UCBC = '/lua/editor/UnitCountBuildConditions.lua'
local EBC = '/lua/editor/EconomyBuildConditions.lua'
local IBC = '/lua/editor/InstantBuildConditions.lua'
local TBC = '/lua/editor/ThreatBuildConditions.lua'
local SAI = '/lua/ScenarioPlatoonAI.lua'
local SBC = '/lua/editor/SorianBuildConditions.lua'
local MIBC = '/lua/editor/MiscBuildConditions.lua'

function SeaAttackCondition(aiBrain, locationType, targetNumber)
    local pool = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')

    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager then
        return false
    end

    local position = engineerManager:GetLocationCoords()
    local radius = engineerManager.Radius

    local surfaceThreat = pool:GetPlatoonThreat('AntiSurface', categories.MOBILE * categories.NAVAL, position, radius)
    local subThreat = pool:GetPlatoonThreat('AntiSub', categories.MOBILE * categories.NAVAL, position, radius)
    if (surfaceThreat + subThreat) > targetNumber then
        return true
    end
    return false
end

BuilderGroup {
    BuilderGroupName = 'SCTANavalFormer',
    BuildersType = 'PlatoonFormBuilder',
    Builder {
        BuilderName = 'SCTA Scout Ships',
        PlatoonTemplate = 'SCTAPatrolBoatAttack',
        Priority = 100,
        InstanceCount = 2,
        BuilderType = 'Any',
        BuilderConditions = {
            { UCBC, 'PoolGreaterAtLocation', { 'LocationType', 0, categories.NAVAL * categories.SCOUT } },
         },
    },
    Builder {
        BuilderName = 'SCTA T1 Naval Assault',
        PlatoonTemplate = 'SCTANavalAssault',
        Priority = 50,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Naval',
                SecondaryThreatTargetType = 'Economy',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, 'MOBILE TECH3 NAVAL' } },
            { SeaAttackCondition, { 'LocationType', 50 } }, 
        },
    },
    Builder {
        BuilderName = 'SCTA HighTech',
        PlatoonTemplate = 'SCTANavalAssaultT2',
        Priority = 75,
        InstanceCount = 10,
        BuilderType = 'Any',
        BuilderData = {
            UseFormation = 'AttackFormation',
            ThreatWeights = {
                IgnoreStrongerTargetsRatio = 100.0,  #DUNCAN - uncommented, was 100
                PrimaryThreatTargetType = 'Naval',
                SecondaryThreatTargetType = 'Economy',
                SecondaryThreatWeight = 0.1,
                WeakAttackThreatWeight = 1,
                VeryNearThreatWeight = 10,
                NearThreatWeight = 5,
                MidThreatWeight = 1,
                FarThreatWeight = 1,
            },
        },
        BuilderConditions = {
            { UCBC, 'UnitsLessAtLocation', { 'LocationType', 1, 'MOBILE TECH3 NAVAL' } },
            { SeaAttackCondition, { 'LocationType', 50 } }, 
        },
    },
}


BuilderGroup {
    BuilderGroupName = 'SCTAAINavalBuilder',
    BuildersType = 'FactoryBuilder',
    Builder {
        BuilderName = 'SCTAAi Factory ScoutShip',
        PlatoonTemplate = 'T1ScoutShipSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.5, categories.OCEAN * categories.SCOUT,
            '<=', categories.OCEAN} },
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Frigate Naval',
        PlatoonTemplate = 'T1FrigateSCTA',
        Priority = 90,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.33, categories.OCEAN * categories.FRIGATE,
            '<=', categories.OCEAN - categories.ENGINEER } },
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.LAB * categories.NAVAL } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Destroyer Naval',
        PlatoonTemplate = 'T2DestroyerSCTA',
        Priority = 125,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.33, categories.OCEAN * categories.DESTROYER,
            '<=', categories.OCEAN - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi AntiAir Naval',
        PlatoonTemplate = 'T2CrusSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveUnitRatio', { 0.1, categories.OCEAN * categories.CRUISER,
            '<=', categories.OCEAN - categories.ENGINEER } },
            { EBC, 'GreaterThanEconStorageRatio', { 0.15, 0.25}},
        },
        BuilderType = 'Sea',
    },
    Builder {
        BuilderName = 'SCTAAi Battleship',
        PlatoonTemplate = 'BattleshipSCTA',
        Priority = 100,
        BuilderConditions = {
            { UCBC, 'HaveLessThanUnitsWithCategory', { 2, categories.BATTLESHIP } }, -- Stop after 10 facs have been built.
            { EBC, 'GreaterThanEconStorageRatio', { 0.3, 0.5}},
        },
        BuilderType = 'Sea',
    },
}
