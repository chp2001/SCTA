local AIUtils = import('/lua/ai/AIUtilities.lua')

------AIUTILITIES FUNCTIONS (RNG, NUTCTACKER, and RECLAIM MY OW
function CheckBuildPlatoonDelaySCTA(aiBrain, PlatoonName)
    if aiBrain.DelayEqualBuildPlattons[PlatoonName] then
        --LOG('Delay Platoon Name exist' ..aiBrain.DelayEqualBuildPlattons[PlatoonName])
    end
    if aiBrain.DelayEqualBuildPlattons[PlatoonName] and aiBrain.DelayEqualBuildPlattons[PlatoonName] > GetGameTimeSeconds() then
        --LOG('Builder Delay false')
        return false
    end
   --LOG('Builder delay true')
    return true
end

function HaveUnitsInCategoryBeingUpgradeSCTA(aiBrain, numunits, category, compareType)
    -- get all units matching 'category'
    local unitsBuilding = aiBrain:GetListOfUnits(category, false)
    local numBuilding = 0
    -- own armyIndex
    local armyIndex = aiBrain:GetArmyIndex()
    -- loop over all units and search for upgrading units
    for unitNum, unit in unitsBuilding do
        if not unit.Dead and not unit:BeenDestroyed() and unit:IsUnitState('Upgrading') and unit:GetAIBrain():GetArmyIndex() == armyIndex then
            numBuilding = numBuilding + 1
        end
    end
    --LOG(aiBrain:GetArmyIndex()..' HaveUnitsInCategoryBeingUpgrade ( '..numBuilding..' '..compareType..' '..numunits..' ) --  return '..repr(CompareBody(numBuilding, numunits, compareType))..' ')
    return CompareBodySCTA(numBuilding, numunits, compareType)
end

function HaveLessThanUnitsInCategoryBeingUpgradeSCTA(aiBrain, numunits, category)
    return HaveUnitsInCategoryBeingUpgradeSCTA(aiBrain, numunits, category, '<')
end

function CompareBodySCTA(numOne, numTwo, compareType)
    if compareType == '>' then
        if numOne > numTwo then
            return true
        end
    elseif compareType == '<' then
        if numOne < numTwo then
            return true
        end
    elseif compareType == '>=' then
        if numOne >= numTwo then
            return true
        end
    elseif compareType == '<=' then
        if numOne <= numTwo then
            return true
        end
    else
       --error('*AI ERROR: Invalid compare type: ' .. compareType)
       return false
    end
    return false
end


function TAHavePoolUnitInArmy(aiBrain, unitCount, unitCategory, compareType)
    local poolPlatoon = aiBrain:GetPlatoonUniquelyNamed('ArmyPool')
    local numUnits = poolPlatoon:GetNumCategoryUnits(unitCategory)
    --LOG('* HavePoolUnitInArmy: numUnits= '..numUnits) 
    return CompareBodySCTA(numUnits, unitCount, compareType)
end

function TAHaveLessThanArmyPoolWithCategory(aiBrain, unitCount, unitCategory)
    return TAHavePoolUnitInArmy(aiBrain, unitCount, unitCategory, '<=')
end
function TAHaveGreaterThanArmyPoolWithCategory(aiBrain, unitCount, unitCategory)
    return TAHavePoolUnitInArmy(aiBrain, unitCount, unitCategory, '>=')
end

--TA Build Conditions

function TAAIGetEconomyNumbersStorageRatio(aiBrain)
    local econ = {}
    econ.MassStorageRatio = aiBrain:GetEconomyStoredRatio('MASS')
    econ.EnergyStorageRatio = aiBrain:GetEconomyStoredRatio('ENERGY')
    econ.EnergyStorage = aiBrain:GetEconomyStored('ENERGY')
    econ.MassStorage = aiBrain:GetEconomyStored('MASS')

    if econ.MassStorageRatio ~= 0 then
        econ.MassMaxStored = econ.MassStorage / econ.MassStorageRatio
    else
        econ.MassMaxStored = econ.MassStorage
    end

    if econ.EnergyStorageRatio ~= 0 then
        econ.EnergyMaxStored = econ.EnergyStorage / econ.EnergyStorageRatio
    else
        econ.EnergyMaxStored = econ.EnergyStorage
    end

    return econ
end


function GreaterThanStorageRatioTA(aiBrain, mStorageRatio, eStorageRatio)
    local econ = TAAIGetEconomyNumbersStorageRatio(aiBrain)
    if (econ.MassStorageRatio >= mStorageRatio and econ.EnergyStorageRatio >= eStorageRatio) then
        return true
    end
    return false
end

-----TAExpansion

function TAExpansionBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum = tonumber(ScenarioInfo.Options.LandExpansionsAllowed)/5 or 1 
    return TAExpansionBaseCount(aiBrain, '<', checkNum)
end

function TAExpansionBaseCount(aiBrain, compareType, checkNum)
    local expBaseCount = aiBrain:GetManagerCount('Expansion Area')
        ---LOG('*SCTAEXPANSIONTA', expBaseCount)
       if expBaseCount > checkNum then
       end
       return CompareBodySCTA(expBaseCount, checkNum, compareType)
end

function TAStartBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum2 = tonumber(ScenarioInfo.Options.LandExpansionsAllowed)/3 or 2 
    return TAStartBaseCount(aiBrain, '<', checkNum2)
end

function TAStartBaseCount(aiBrain, compareType, checkNum2)
       local expBaseCount2 = aiBrain:GetManagerCount('Start Location')
       ----LOG('*SCTAEXPANSIONTA2', expBaseCount2)
       if expBaseCount2 > checkNum2 + 1 then
       end
       return CompareBodySCTA(expBaseCount2, checkNum2, compareType)
end

--[[function FormerBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum = 5
    return StartBaseCount(aiBrain, '<', checkNum)
end

function FormerBaseCheck(aiBrain, compareType, checkNum)
       local expBaseCount = aiBrain:GetManagerCount('Mass')
       if expBaseCount > checkNum then
       end
       return CompareBodySCTA(expBaseCount, checkNum, compareType)
end]]

function TAHaveUnitsWithCategoryAndAllianceFalse(aiBrain, numReq, category, alliance)
    local numUnits = aiBrain:GetNumUnitsAroundPoint(category, Vector(0,0,0), 100000, alliance)
    if numUnits > numReq then
        return false
    end
    return true
end

---TAUnit Building

function TAFactoryCapCheck(aiBrain, locationType, TECH)
    local catCheck = false
    catCheck = TECH * categories.FACTORY
    local factoryManager = aiBrain.BuilderManagers[locationType].FactoryManager
    if not factoryManager then
        WARN('*AI WARNING: FactoryCapCheck - Invalid location - ' .. locationType)
        return false
    end
    local numUnits = factoryManager:GetNumCategoryFactories(catCheck)
    numUnits = numUnits + aiBrain:GetEngineerManagerUnitsBeingBuilt(catCheck)

    if numUnits < 12 then
        return true
    end
    return false
end

function TAHaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, compareType)
    if not aiBrain.BuilderManagers[locationType] then
        WARN('*AI WARNING: HaveEnemyUnitAtLocation - Invalid location - ' .. locationType)
        return false
    elseif not aiBrain.BuilderManagers[locationType].Position then
        WARN('*AI WARNING: HaveEnemyUnitAtLocation - Invalid position - ' .. locationType)
        return false
    end
    local numEnemyUnits = aiBrain:GetNumUnitsAroundPoint(categoryEnemy, aiBrain.BuilderManagers[locationType].Position, radius , 'Enemy')
    --LOG(aiBrain:GetArmyIndex()..' CompareBody {World} radius:['..radius..'] '..repr(DEBUG)..' ['..numEnemyUnits..'] '..compareType..' ['..unitCount..'] return '..repr(CompareBody(numEnemyUnits, unitCount, compareType)))
    return CompareBodySCTA(numEnemyUnits, unitCount, compareType)
end
--            { UCBC, 'EnemyUnitsGreaterAtLocationRadius', {  BasePanicZone, 'LocationType', 0, categories.MOBILE * categories.LAND }}, -- radius, LocationType, unitCount, categoryEnemy
function TAEnemyUnitsGreaterAtLocationRadius(aiBrain, radius, locationType, unitCount, categoryEnemy)
    return TAHaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, '>')
end
--            { UCBC, 'EnemyUnitsLessAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.LAND }}, -- radius, LocationType, unitCount, categoryEnemy
function TAEnemyUnitsLessAtLocationRadius(aiBrain, radius, locationType, unitCount, categoryEnemy)
    return TAHaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, '<')
end


function TAAttackNaval(aiBrain, bool)
    local startX, startZ = aiBrain:GetArmyStartPos()
    local AIAttackUtils = import('/lua/AI/aiattackutilities.lua')
    local enemyX, enemyZ
    if aiBrain:GetCurrentEnemy() then
        enemyX, enemyZ = aiBrain:GetCurrentEnemy():GetArmyStartPos()
    end
    local navalMarker = AIUtils.AIGetClosestMarkerLocation(aiBrain, 'Naval Area', startX, startZ)
    local path, reason = false
    if enemyX then
        path, reason = AIAttackUtils.PlatoonGenerateSafePathTo(aiBrain, 'Water', {startX,0,startZ}, {enemyX,0,enemyZ}, 10)
    end
    if (navalMarker and path) and bool then
        return true
    end
    return false
end

function TAHaveUnitRatioGreaterThanLand(aiBrain, Land)
    local numOne = aiBrain:GetCurrentUnits((Land) * categories.LAND * categories.MOBILE - categories.ENGINEER)
    local numTwo = aiBrain:GetCurrentUnits(categories.LAND * categories.MOBILE - categories.ENGINEER)
    if ((numOne + 1) / (numTwo + 1)) < 0.33 then
        return true
    end
    return false
end

function TAHaveUnitRatioGreaterThanNavalT1(aiBrain, Naval)
    local numOne = aiBrain:GetCurrentUnits(Naval)
    local numTwo = aiBrain:GetCurrentUnits(categories.SCOUT * categories.NAVAL)
    if ((numOne + 1) / (numTwo + 1)) < 0.2 then
        return true
    end
    return false
end

function TAHaveUnitRatioGreaterThanNaval(aiBrain, Naval)
    local numOne = aiBrain:GetCurrentUnits(Naval)
    local numTwo = aiBrain:GetCurrentUnits(categories.FACTORY * categories.NAVAL * categories.TECH2)
    if ((numOne + 1) / (numTwo + 1)) < 2 then
        return true
    end
    return false
end

function TAHaveUnitRatioGreaterThanNavalT3(aiBrain, Naval)
    local numOne = aiBrain:GetCurrentUnits(Naval)
    local numTwo = aiBrain:GetCurrentUnits(categories.FACTORY * categories.NAVAL * categories.TECH2)
    if ((numOne + 1) / (numTwo + 2)) < 1 then
        return true
    end
    return false
end
----TAReclaim

function TAReclaimablesInArea(aiBrain, locType)
    --DUNCAN - was .9. Reduced as dont need to reclaim yet if plenty of mass
    if aiBrain:GetEconomyStoredRatio('MASS') > .5 then
        return false
    end

    --DUNCAN - who cares about energy for reclaming?
    --if aiBrain:GetEconomyStoredRatio('ENERGY') > .5 then
        --return false
    --end

    local ents = TAAIGetReclaimablesAroundLocation(aiBrain, locType)
    if ents and table.getn(ents) > 0 then
        return true
    end

    return false
end

function TAAIGetReclaimablesAroundLocation(aiBrain, locationType)
    local position, radius
    if aiBrain.HasPlatoonList then
        for _, v in aiBrain.PBM.Locations do
            if v.LocationType == locationType then
                position = v.Location
                radius = v.Radius
                break
            end
        end
    elseif aiBrain.BuilderManagers[locationType] then
        radius = aiBrain.BuilderManagers[locationType].FactoryManager.Radius
        position = aiBrain.BuilderManagers[locationType].FactoryManager:GetLocationCoords()
    end

    if not position then
        return false
    end

    local x1 = position[1] - radius * 2
    local x2 = position[1] + radius * 2
    local z1 = position[3] - radius * 2
    local z2 = position[3] + radius * 2
    local rect = Rect(x1, z1, x2, z2)

    return AIUtils.GetReclaimablesInRect(rect)
end


local TAAITaunts = {
    {99, 100, 101, 102, 103}, -- Seraphim
}
local AIChatText = import('/lua/AI/sorianlang.lua').AIChatText

function TAAIRandomizeTaunt(aiBrain)
    tauntid = Random(1,table.getn(TAAITaunts[1]))
    TAAISendChat('all', aiBrain.Nickname, '/'..TAAITaunts[1][tauntid])
end

function TAAISendChat(aigroup, ainickname, aiaction, targetnickname, extrachat)
        if aiaction and AIChatText[aiaction] then
            local ranchat = Random(1, table.getn(AIChatText[aiaction]))
            local chattext
            if targetnickname then
                chattext = string.gsub(AIChatText[aiaction][ranchat],'%[target%]', targetnickname)
            elseif extrachat then
                chattext = string.gsub(AIChatText[aiaction][ranchat],'%[extra%]', extrachat)
            else
                chattext = AIChatText[aiaction][ranchat]
            end
            table.insert(Sync.AIChat, {group=aigroup, text=chattext, sender=ainickname})
        else
            table.insert(Sync.AIChat, {group=aigroup, text=aiaction, sender=ainickname})
        end
end

function TACanBuildOnMassLessThanDistanceLand(aiBrain, locationType, distance, threatMin, threatMax, threatRings, threatType, maxNum )
    local engineerManager = aiBrain.BuilderManagers[locationType].EngineerManager
    if not engineerManager or locationType == 'Naval Area' then
        return false
    end
    local position = engineerManager:GetLocationCoords()
    local markerTable = AIUtils.AIGetSortedMassLocations(aiBrain, maxNum, threatMin, threatMax, threatRings, threatType, position)
    if markerTable[1] and VDist3( markerTable[1], position ) < distance then
        local dist = VDist3( markerTable[1], position )
        return true
    end
    return false
end