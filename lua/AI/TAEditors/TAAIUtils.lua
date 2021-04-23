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

function ExpansionBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum = tonumber(ScenarioInfo.Options.LandExpansionsAllowed)/5 or 1 
    return ExpansionBaseCount(aiBrain, '<', checkNum)
end

function ExpansionBaseCount(aiBrain, compareType, checkNum)
    local expBaseCount = aiBrain:GetManagerCount('Expansion Area')
        ---LOG('*SCTAEXPANSIONTA', expBaseCount)
       if expBaseCount > checkNum then
       end
       return CompareBodySCTA(expBaseCount, checkNum, compareType)
end

function StartBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum2 = tonumber(ScenarioInfo.Options.LandExpansionsAllowed)/3 or 2 
    return StartBaseCount(aiBrain, '<', checkNum2)
end

function StartBaseCount(aiBrain, compareType, checkNum2)
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

function HaveUnitsWithCategoryAndAllianceFalse(aiBrain, numReq, category, alliance)
    local numUnits = aiBrain:GetNumUnitsAroundPoint(category, Vector(0,0,0), 100000, alliance)
    if numUnits > numReq then
        return false
    end
    return true
end


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

function HaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, compareType)
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
function EnemyUnitsGreaterAtLocationRadius(aiBrain, radius, locationType, unitCount, categoryEnemy)
    return HaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, '>')
end
--            { UCBC, 'EnemyUnitsLessAtLocationRadius', {  BasePanicZone, 'LocationType', 1, categories.MOBILE * categories.LAND }}, -- radius, LocationType, unitCount, categoryEnemy
function EnemyUnitsLessAtLocationRadius(aiBrain, radius, locationType, unitCount, categoryEnemy)
    return HaveEnemyUnitAtLocation(aiBrain, radius, locationType, unitCount, categoryEnemy, '<')
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

--[[TABuildScoutLocations = function(self)
    local aiBrain = self
    local opponentStarts = {}
    local allyStarts = {}

    if not aiBrain.InterestList then
        aiBrain.InterestList = {}
        aiBrain.IntelData.HiPriScouts = 0
        aiBrain.IntelData.AirHiPriScouts = 0
        aiBrain.IntelData.AirLowPriScouts = 0

        -- Add each enemy's start location to the InterestList as a new sub table
        aiBrain.InterestList.HighPriority = {}
        aiBrain.InterestList.LowPriority = {}
        aiBrain.InterestList.MustScout = {}

        local myArmy = ScenarioInfo.ArmySetup[self.Name]

        if ScenarioInfo.Options.TeamSpawn == 'fixed' then
            -- Spawn locations were fixed. We know exactly where our opponents are.
            -- Don't scout areas owned by us or our allies.
            local numOpponents = 0
            for i = 1, 16 do
                local army = ScenarioInfo.ArmySetup['ARMY_' .. i]
                local startPos = ScenarioUtils.GetMarker('ARMY_' .. i).position
                if army and startPos then
                    if army.ArmyIndex ~= myArmy.ArmyIndex and (army.Team ~= myArmy.Team or army.Team == 1) then
                    -- Add the army start location to the list of interesting spots.
                    opponentStarts['ARMY_' .. i] = startPos
                    numOpponents = numOpponents + 1
                    table.insert(aiBrain.InterestList.HighPriority,
                        {
                            Position = startPos,
                            LastScouted = 0,
                        }
                    )
                    else
                        allyStarts['ARMY_' .. i] = startPos
                    end
                end
            end

            aiBrain.NumOpponents = numOpponents

            -- For each vacant starting location, check if it is closer to allied or enemy start locations (within 100 ogrids)
            -- If it is closer to enemy territory, flag it as high priority to scout.
            local starts = AIUtils.AIGetMarkerLocations(aiBrain, 'Mass')
            for _, loc in starts do
                -- If vacant
                if not opponentStarts[loc.Name] and not allyStarts[loc.Name] then
                    local closestDistSq = 999999999
                    local closeToEnemy = false

                    for _, pos in opponentStarts do
                        local distSq = VDist2Sq(pos[1], pos[3], loc.Position[1], loc.Position[3])
                        -- Make sure to scout for bases that are near equidistant by giving the enemies 100 ogrids
                        if distSq-10000 < closestDistSq then
                            closestDistSq = distSq-10000
                            closeToEnemy = true
                        end
                    end

                    for _, pos in allyStarts do
                        local distSq = VDist2Sq(pos[1], pos[3], loc.Position[1], loc.Position[3])
                        if distSq < closestDistSq then
                            closestDistSq = distSq
                            closeToEnemy = false
                            break
                        end
                    end

                    if closeToEnemy then
                        table.insert(aiBrain.InterestList.LowPriority,
                            {
                                Position = loc.Position,
                                LastScouted = 0,
                            }
                        )
                    end
                end
            end
        end
        aiBrain:ForkThread(self.ParseIntelThread)
    end
end,]]