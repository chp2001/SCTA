local util = import('/lua/utilities.lua')
local AIUtils = import('/lua/ai/AIUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local Factions = import('/lua/factions.lua').GetFactions(true)

CreateTABuildingEffects = function(builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag)
    WaitSeconds(0.75)
    local selfPosition = builder:GetPosition()
    local targetPosition = unitBeingBuilt:GetPosition()
    local distance = util.GetDistanceBetweenTwoVectors(selfPosition, targetPosition)
        for _, vBone in BuildEffectBones do
        BuildEffectsBag:Add(CreateAttachedEmitter(builder, vBone, builder.Army, '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1):SetEmitterCurveParam('LIFETIME_CURVE',distance,0))
        end
end
    

CreateTAAirBuildingEffects = function(builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag)
    WaitSeconds(0.75)
    for _, vBone in BuildEffectBones do
        BuildEffectsBag:Add(CreateAttachedEmitter(builder, vBone, builder.Army, '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1))
        end
    end



CreateTAFactBuildingEffects = function(builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag)
    WaitSeconds(0.1)
    for _, vBone in BuildEffectBones do
        BuildEffectsBag:Add(CreateAttachedEmitter(builder, vBone, builder.Army, '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.05))
        end
    end

CreateTASeaFactBuildingEffects = function(builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag)
    WaitSeconds(0.1)
    for _, vBone in BuildEffectBones do
        BuildEffectsBag:Add(CreateAttachedEmitter(builder, vBone, builder.Army, '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.08):SetEmitterCurveParam('LIFETIME_CURVE',10,0))
        end
    end

CreateTAGantBuildingEffects = function(builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag)
    WaitSeconds(0.75)
    for _, vBone in BuildEffectBones do
        BuildEffectsBag:Add( CreateAttachedEmitter( builder, vBone, builder.Army,  '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.18):OffsetEmitter(0,0,-0.2))
        end
    end


TAReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, ReclaimEffectsBag)
    WaitSeconds(1)
    local selfPosition = reclaimer:GetPosition()
    local targetPosition = reclaimed:GetPosition()
    local distance = util.GetDistanceBetweenTwoVectors(selfPosition, targetPosition)
        for _, vBone in BuildEffectBones do
            ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, vBone, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.05):OffsetEmitter(0,0,1.5):SetEmitterCurveParam('LIFETIME_CURVE',distance,0):SetEmitterCurveParam('Z_POSITION_CURVE',distance * 10,0))
        end
    end

TACommanderReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, ReclaimEffectsBag)
        WaitSeconds(1)
        local selfPosition = reclaimer:GetPosition()
        local targetPosition = reclaimed:GetPosition()
        local distance = util.GetDistanceBetweenTwoVectors(selfPosition, targetPosition)
            for _, vBone in BuildEffectBones do
                ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, vBone, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.1):OffsetEmitter(0,0,1):SetEmitterCurveParam('LIFETIME_CURVE',distance,0):SetEmitterCurveParam('Z_POSITION_CURVE',distance * 10,0))
            end
        end



TAAirReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, ReclaimEffectsBag)
    WaitSeconds(1)
    local selfPosition = reclaimer:GetPosition()
    local targetPosition = reclaimed:GetPosition()
    local distance = util.GetDistanceBetweenTwoVectors(selfPosition, targetPosition)
        for _, vBone in BuildEffectBones do
            ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, vBone, reclaimer:GetArmy(), '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.05):OffsetEmitter(0.1,0,1):SetEmitterCurveParam('LIFETIME_CURVE',distance,0):SetEmitterCurveParam('Z_POSITION_CURVE',distance * 10,0))
        end
    end


TACaptureEffect = function(capturer, captive, BuildEffectBones, CaptureEffectsBag)  
    WaitSeconds(0.75)
    local selfPosition = capturer:GetPosition()
    local targetPosition = captive:GetPosition()
    local distance = util.GetDistanceBetweenTwoVectors(selfPosition, targetPosition)
    for _, vBone in BuildEffectBones do
        CaptureEffectsBag:Add( CreateAttachedEmitter( capturer, vBone, capturer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.1):OffsetEmitter(0,0,0.5):SetEmitterCurveParam('LIFETIME_CURVE',distance,0):SetEmitterCurveParam('Z_POSITION_CURVE',distance * 10,0))
    end
end



updateBuildRestrictions = function(self)
    local aiBrain = self:GetAIBrain()
    
    --Add build restrictions
    --EngiModFinalFORMTA
    ---Basicallys Stop Lower Tech from building UpperTech. Advanced Factories now full access to builds
    ---Will require another rebalancing of Seaplanes and Hovers
    if EntityCategoryContains(categories.TECH1 * categories.CONSTRUCTION - categories.FACTORY, self) then
        self:AddBuildRestriction(categories.TECH2)
        self.restrictions = true   
    elseif EntityCategoryContains(categories.TECH2 * categories.CONSTRUCTION - categories.RESEARCH, self) then
        self:AddBuildRestriction(categories.TECH3)
        self.restrictions = true
    end

    if self.restrictions then
    local gtime = GetGameTimeSeconds()
    local HQCategory = ((categories.RESEARCH + categories.GATE) * (categories.ARM + categories.CORE)) 
        if self.FindHQType(aiBrain, HQCategory * (categories.TECH3 + categories.EXPERIMENTAL)) or gtime > 1500 then
                self:RemoveBuildRestriction(categories.TECH2)
                self:RemoveBuildRestriction(categories.TECH3)
                self.restrictions = nil     
        elseif self.FindHQType(aiBrain, HQCategory * categories.TECH2) or  gtime > 600 then
            if EntityCategoryContains(categories.TECH1, self) then
            self:RemoveBuildRestriction(categories.TECH2)    
            self.restrictions = nil
            end
        end
    end
end

--self.FindHQType(aiBrain, category)
FindHQType = function(aiBrain, category)
    for id, unit in aiBrain:GetListOfUnits((categories.RESEARCH + categories.GATE) * (categories.ARM + categories.CORE)) do
        if not unit:IsBeingBuilt() then
            return true
        end
    end
    return false
end


targetingFacilityData = {}

function registerTargetingFacility(army)
    if (targetingFacilityData[army]) then
        targetingFacilityData[army] = targetingFacilityData[army] + 1
    else
        targetingFacilityData[army] = 1
    end

end

function unregisterTargetingFacility(army)
    if (targetingFacilityData[army]) then
        targetingFacilityData[army] = targetingFacilityData[army] - 1
    else
        targetingFacilityData[army] = 0
    end
end

function ArmyHasTargetingFacility(army)
    return (targetingFacilityData[army] > 0 and GetArmyBrain(army):GetEconomyStored('ENERGY') > 0)
end

function TAGetEngineerFaction(engineer)
    if EntityCategoryContains(categories.ARM, engineer) then
        return 'Arm'
    elseif EntityCategoryContains(categories.CORE, engineer) then
        return 'Core'
    else
        return false
    end
end

function CheckBuildPlatoonDelaySCTA(aiBrain, PlatoonName)
    if aiBrain.DelayEqualBuildPlatoons[PlatoonName] then
        --LOG('Delay Platoon Name exist' ..aiBrain.DelayEqualBuildPlattons[PlatoonName])
    end
    if aiBrain.DelayEqualBuildPlatoons[PlatoonName] and aiBrain.DelayEqualBuildPlattons[PlatoonName] > GetGameTimeSeconds() then
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


function GetDirectionInDegrees( v1, v2 )
    local SCTAACOS = math.acos
    local PI = math.pi
    local vec = GetDirectionVector( v1, v2)
    
    if vec[1] >= 0 then
        return SCTACOS(vec[3]) * (360/(PI*2))
    end
    
    return 360 - (SCTACOS(vec[3]) * (360/(PI*2)))
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