local util = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local EffectTemplate = import('/lua/EffectTemplates.lua')
local Factions = import('/lua/factions.lua').GetFactions(true)

CreateTABuildingEffects = function( self, unitBeingBuilt, order )
    EffectUtil.CreateSeraphimUnitEngineerBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
    WaitSeconds(0.75)
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
    end
end

CreateTAAirBuildingEffects = function( self, unitBeingBuilt, order )
    WaitSeconds(0.75)
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
    end
    EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
end


CreateTAFactBuildingEffects = function( self, unitBeingBuilt, order )  
    WaitSeconds( 0.1 )
    for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.05) )         
    end
    EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
end

CreateTASeaFactBuildingEffects = function( self, unitBeingBuilt, order )
    WaitSeconds( 0.1 )
    for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
    end
    EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
end

CreateTAGantBuildingEffects = function(self, unitBeingBuilt, order)
    WaitSeconds( 0.75 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.18):OffsetEmitter(0,0,-0.2))         
    end
    EffectUtil.CreateCybranFactoryBuildEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones, self.BuildEffectsBag )
end

TAReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, EffectsBag)
    EffectUtil.PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
    WaitSeconds(0.75)
    if not reclaimer.Dead and not IsDestroyed(reclaimed) then
    for k, v in reclaimer:GetBlueprint().General.BuildBones.BuildEffectBones do
		reclaimer.ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, v, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.08):OffsetEmitter(0,0,3))
    end
    end      
end

TAAirReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, EffectsBag)
    EffectUtil.PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
    WaitSeconds(0.75)
    if not reclaimer.Dead and not IsDestroyed(reclaimed) then
    for k, v in reclaimer:GetBlueprint().General.BuildBones.BuildEffectBones do
		reclaimer.ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, v, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.05):OffsetEmitter(0.1,0,1))
    end
end      
end


TACaptureEffect = function(capturer, captive, BuildEffectBones, EffectsBag)
    EffectUtil.PlayCaptureEffects(capturer, captive, BuildEffectBones, EffectsBag)    
    WaitSeconds(0.75)
    if not capturer.Dead and not IsDestroyed(captive) then
    for k, v in capturer:GetBlueprint().General.BuildBones.BuildEffectBones do
		capturer.CaptureEffectsBag:Add( CreateAttachedEmitter( capturer, v, capturer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.08):OffsetEmitter(0,-0.05,2))
    end
end
end



updateBuildRestrictions = function(self)
    local aiBrain = self:GetAIBrain()
    --Add build restrictions
    --EngiModFinalFORMTA
    ---Basicallys Stop Lower Tech from building UpperTech. Advanced Factories now full access to builds
    ---Will require another rebalancing of Seaplanes and Hovers
    if EntityCategoryContains(categories.LEVEL1 * categories.CONSTRUCTION - categories.PLANT, self) then
        self:AddBuildRestriction(categories.LEVEL2)
        self:AddBuildRestriction(categories.LEVEL3)
        self.restrictions = true   
    elseif EntityCategoryContains(categories.LEVEL2 * categories.CONSTRUCTION - categories.PLANT, self) then
        self:AddBuildRestriction(categories.LEVEL3)
        self.restrictions = true
    end

    if self.restrictions then
    local gtime = GetGameTimeSeconds()
    local HQCategory = categories.PLANT
        if self.FindHQType(aiBrain, HQCategory * categories.LEVEL3) or  gtime > 1080 then
            self:RemoveBuildRestriction(categories.LEVEL2)
            self:RemoveBuildRestriction(categories.LEVEL3)
        elseif self.FindHQType(aiBrain, HQCategory * categories.LEVEL2) or gtime > 600 then
            self:RemoveBuildRestriction(categories.LEVEL2)
        end
    end
end

--self.FindHQType(aiBrain, category)
FindHQType = function(aiBrain, category)
    for id, unit in aiBrain:GetListOfUnits(categories.PLANT) do
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