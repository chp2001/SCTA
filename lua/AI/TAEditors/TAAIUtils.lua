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
    local checkNum = 2
    return ExpansionBaseCount(aiBrain, '<', checkNum)
end

function ExpansionBaseCount(aiBrain, compareType, checkNum)
       local expBaseCount = aiBrain:GetManagerCount('Expansion Area')
        if expBaseCount > checkNum then
       end
       return CompareBodySCTA(expBaseCount, checkNum, compareType)
end

function StartBaseCheck(aiBrain)
    -- Removed automatic setting of Land-Expasions-allowed. We have a Game-Option for this.
    local checkNum = 1
    return StartBaseCount(aiBrain, '<', checkNum)
end

function StartBaseCount(aiBrain, compareType, checkNum)
       local expBaseCount = aiBrain:GetManagerCount('Start Location')
       if expBaseCount > checkNum + 1 then
       end
       return CompareBodySCTA(expBaseCount, checkNum, compareType)
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
