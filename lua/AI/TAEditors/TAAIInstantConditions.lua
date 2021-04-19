local AIUtils = import('/lua/ai/AIUtilities.lua')
--local Util = import('utilities.lua')

function TAGetEngineerFaction(engineer)
    if EntityCategoryContains(categories.ARM, engineer) then
        return 'Arm'
    elseif EntityCategoryContains(categories.CORE, engineer) then
        return 'Core'
    else
        return false
    end
end

------AIUTILITIES FUNCTIONS (RNG, NUTCTACKER, and RECLAIM MY OWN)
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

function NormalizeVector( v )

	if v.x then
		v = {v.x, v.y, v.z}
	end
	
    local length = math.sqrt( math.pow( v[1], 2 ) + math.pow( v[2], 2 ) + math.pow(v[3], 2 ) )
	
    if length > 0 then
        local invlength = 1 / length
        return Vector( v[1] * invlength, v[2] * invlength, v[3] * invlength )
    else
        return Vector( 0,0,0 )
    end
end

function GetDirectionVector( v1, v2 )
    return NormalizeVector( Vector(v1[1] - v2[1], v1[2] - v2[2], v1[3] - v2[3]) )
end
-----locational things

function GetDirectionInDegrees( v1, v2 )
    local SCTAACOS = math.acos
    local PI = math.pi
    local vec = GetDirectionVector( v1, v2)
    
    if vec[1] >= 0 then
        return SCTAACOS(vec[3]) * (360/(PI*2))
    end
    
    return 360 - (SCTAACOS(vec[3]) * (360/(PI*2)))
end

function GetMOARadii(bool)
    -- Military area is slightly less than half the map size (10x10map) or maximal 200.
    local BaseMilitaryArea = math.max( ScenarioInfo.size[1]-50, ScenarioInfo.size[2]-50 ) / 2.2
    BaseMilitaryArea = math.max( 180, BaseMilitaryArea )
    -- DMZ is half the map. Mainly used for air formers
    local BaseDMZArea = math.max( ScenarioInfo.size[1]-40, ScenarioInfo.size[2]-40 ) / 2
    -- Restricted Area is half the BaseMilitaryArea. That's a little less than 1/4 of a 10x10 map
    local BaseRestrictedArea = BaseMilitaryArea / 2
    -- Make sure the Restricted Area is not smaller than 50 or greater than 100
    BaseRestrictedArea = math.max( 60, BaseRestrictedArea )
    BaseRestrictedArea = math.min( 120, BaseRestrictedArea )
    -- The rest of the map is enemy area
    local BaseEnemyArea = math.max( ScenarioInfo.size[1], ScenarioInfo.size[2] ) * 1.5
    -- "bool" is only true if called from "AIBuilders/Mobile Land.lua", so we only print this once.
    if bool then
        --LOG('* RNGAI: BaseRestrictedArea= '..math.floor( BaseRestrictedArea * 0.01953125 ) ..' Km - ('..BaseRestrictedArea..' units)' )
        --LOG('* RNGAI: BaseMilitaryArea= '..math.floor( BaseMilitaryArea * 0.01953125 )..' Km - ('..BaseMilitaryArea..' units)' )
        --LOG('* RNGAI: BaseDMZArea= '..math.floor( BaseDMZArea * 0.01953125 )..' Km - ('..BaseDMZArea..' units)' )
        --LOG('* RNGAI: BaseEnemyArea= '..math.floor( BaseEnemyArea * 0.01953125 )..' Km - ('..BaseEnemyArea..' units)' )
    end
    return BaseRestrictedArea, BaseMilitaryArea, BaseDMZArea, BaseEnemyArea
end

---TA Engis Engi Cannot Captur

function SCTAEngineerTryReclaimCaptureArea(aiBrain, eng, pos)
    if not pos then
        return false
    end
    local Reclaiming = false
    -- Check if enemy units are at location
    local checkUnits = aiBrain:GetUnitsAroundPoint( (categories.STRUCTURE + categories.MOBILE) - categories.AIR, pos, 10, 'Enemy')
    -- reclaim units near our building place.
    if checkUnits and table.getn(checkUnits) > 0 then
        for num, unit in checkUnits do
            if unit.Dead or unit:BeenDestroyed() then
                continue
            end
            if not IsEnemy( aiBrain:GetArmyIndex(), unit:GetAIBrain():GetArmyIndex() ) then
                continue
            end
            if EntityCategoryContains(categories.COMMAND, eng) and unit:IsCapturable() then 
                -- reclaim if its a T1 mex and the engineer is a commander
                unit.CaptureInProgress = true
                IssueCapture({eng}, unit)
            else
                -- else reclaim
                unit.ReclaimInProgress = true
                IssueReclaim({eng}, unit)
            end
            Reclaiming = true
        end
    end
    -- reclaim rocks etc or we can't build mexes or hydros
    local Reclaimables = GetReclaimablesInRect(Rect(pos[1], pos[3], pos[1], pos[3]))
    if Reclaimables and table.getn( Reclaimables ) > 0 then
        for k,v in Reclaimables do
            if v.MaxMassReclaim > 0 or v.MaxEnergyReclaim > 0 then
                IssueReclaim({eng}, v)
                Reclaiming = true
            end
        end
    end
    return Reclaiming
end

--TA Build Conditions

function TAAIGetEconomyNumbersMass(aiBrain)
    local econ = {}
    econ.MassStorageRatio = aiBrain:GetEconomyStoredRatio('MASS')
    econ.MassStorage = aiBrain:GetEconomyStored('MASS')

    if econ.MassStorageRatio ~= 0 then
        econ.MassMaxStored = econ.MassStorage / econ.MassStorageRatio
    else
        econ.MassMaxStored = econ.MassStorage
    end

    return econ
end

function TAAIGetEconomyNumbersEnergy(aiBrain)
    local econ = {}
    econ.EnergyStorageRatio = aiBrain:GetEconomyStoredRatio('ENERGY')
    econ.EnergyStorage = aiBrain:GetEconomyStored('ENERGY')

    if econ.EnergyStorageRatio ~= 0 then
        econ.EnergyMaxStored = econ.EnergyStorage / econ.EnergyStorageRatio
    else
        econ.EnergyMaxStored = econ.EnergyStorage
    end

    return econ
end

function TAAIEcoConditionStorage(aiBrain)
    local econStore = {}
    econStore.MassStorageRatio = aiBrain:GetEconomyStoredRatio('MASS')
    econStore.EnergyStorageRatio = aiBrain:GetEconomyStoredRatio('ENERGY')
    econStore.EnergyStorage = aiBrain:GetEconomyStored('ENERGY')
    econStore.MassStorage = aiBrain:GetEconomyStored('MASS')

    if econStore.MassStorageRatio ~= 0 then
        econStore.MassMaxStored = econStore.MassStorage / econStore.MassStorageRatio
    else
        econStore.MassMaxStored = econStore.MassStorage
    end

    if econStore.EnergyStorageRatio ~= 0 then
        econStore.EnergyMaxStored = econStore.EnergyStorage / econStore.EnergyStorageRatio
    else
        econStore.EnergyMaxStored = econStore.EnergyStorage
    end

    return econStore
end

function TAAIEcoConditionEfficiency(aiBrain)
    local econEff = {}
    econEff.EnergyIncome = aiBrain:GetEconomyIncome('ENERGY')
    econEff.MassIncome = aiBrain:GetEconomyIncome('MASS')
    econEff.EnergyRequested = aiBrain:GetEconomyRequested('ENERGY')
    econEff.MassRequested = aiBrain:GetEconomyRequested('MASS')

    if aiBrain.EconomyMonitorThread then
        local econTime = aiBrain:GetEconomyOverTime()

        econEff.EnergyEfficiencyOverTime = math.min(econTime.EnergyIncome / econTime.EnergyRequested, 4)
        econEff.MassEfficiencyOverTime = math.min(econTime.MassIncome / econTime.MassRequested, 4)
    end

    return econEff
end

function TAEnergyEfficiency(aiBrain)
    local econ = {}
    econ.EnergyIncome = aiBrain:GetEconomyIncome('ENERGY')
    econ.EnergyRequested = aiBrain:GetEconomyRequested('ENERGY')

    if aiBrain.EconomyMonitorThread then
        local econTime = aiBrain:GetEconomyOverTime()
        econ.EnergyEfficiencyOverTime = math.min(econTime.EnergyIncome / econTime.EnergyRequested, 2)
    end

    return econ
end

function EcoManagementTA(aiBrain, mStorageRatio, eStorageRatio, EnergyEfficiency, MassEfficiency)
    local econEff = TAAIEcoConditionEfficiency(aiBrain)
    if (econEff.MassEfficiencyOverTime >= MassEfficiency and econEff.EnergyEfficiencyOverTime >= EnergyEfficiency) then
        return true
    end
    local econStore = TAAIEcoConditionStorage(aiBrain)
    if (econStore.MassStorageRatio >= mStorageRatio and econStore.EnergyStorageRatio >= eStorageRatio) then
        return true
    end
    return false
end

function LessMassStorageMaxTA(aiBrain, mStorageRatio)
    local econ = TAAIGetEconomyNumbersMass(aiBrain)
    if (econ.MassStorageRatio < mStorageRatio) then
        return true
    end
    return false
end

function GreaterEnergyStorageMaxTA(aiBrain, eStorageRatio)
    local econ = TAAIGetEconomyNumbersEnergy(aiBrain)
    if (econ.EnergyStorageRatio >= eStorageRatio) then
        return true
    end
    return false
end

function LessThanEconEnergyTAEfficiency(aiBrain, EnergyEfficiency)
    local econ = TAEnergyEfficiency(aiBrain)
    if (econ.EnergyEfficiencyOverTime <= EnergyEfficiency)  then
        return true
    end
    return false
end

function GreaterThanEconEnergyTAEfficiency(aiBrain, EnergyEfficiency)
    local econ = TAEnergyEfficiency(aiBrain)
    if (econ.EnergyEfficiencyOverTime >= EnergyEfficiency) then
        return true
    end
    return false
end

function TARandomLocation(x,z, value)
	
	local Random = Random
	local r_value = value or 20

    local finalX = x + Random(-r_value, r_value)
	
	-- there is potential here for a hung loop if the random value cannot overcome the map boundary
    while finalX <= 0 or finalX >= ScenarioInfo.size[1] do
	
        finalX = x + Random(-r_value, r_value)
		
    end
	
    local finalZ = z + Random(-r_value, r_value)
	
    while finalZ <= 0 or finalZ >= ScenarioInfo.size[2] do
	
        finalZ = z + Random(-r_value, r_value)
		
    end
	
    local height = GetTerrainHeight( finalX, finalZ )
	
    if GetSurfaceHeight( finalX, finalZ ) > height then
	
        height = GetSurfaceHeight( finalX, finalZ )
		
    end
	
    return { finalX, height, finalZ }
end

