local util = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local EffectTemplate = import('/lua/EffectTemplates.lua')

CreateTABuildingEffects = function( self, unitBeingBuilt, order )
    WaitSeconds(0.75)
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
    end
    EffectUtil.CreateSeraphimUnitEngineerBuildingEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
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
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.3) )         
    end
    EffectUtil.CreateDefaultBuildBeams( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones.BuildEffectBones, self.BuildEffectsBag )
end

CreateTAGantBuildingEffects = function(self, unitBeingBuilt, order)
    WaitSeconds( 0.75 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.2):OffsetEmitter(0,0,-0.5))         
    end
    EffectUtil.CreateCybranFactoryBuildEffects( self, unitBeingBuilt, self:GetBlueprint().General.BuildBones, self.BuildEffectsBag )
end

TAReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, EffectsBag)
    WaitSeconds(0.75)
    EffectUtil.PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
    for k, v in reclaimer:GetBlueprint().General.BuildBones.BuildEffectBones do
		reclaimer.ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, v, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.08):OffsetEmitter(0,0,3))
    end      
end

TAAirReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, EffectsBag)
    WaitSeconds(0.75)
    EffectUtil.PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
    for k, v in reclaimer:GetBlueprint().General.BuildBones.BuildEffectBones do
		reclaimer.ReclaimEffectsBag:Add( CreateAttachedEmitter( reclaimer, v, reclaimer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.05):OffsetEmitter(0.1,0,1))
    end      
end


TACaptureEffect = function(capturer, captive, BuildEffectBones, EffectsBag)
    WaitSeconds(0.75)
    EffectUtil.PlayCaptureEffects(capturer, captive, BuildEffectBones, EffectsBag)    
    for k, v in capturer:GetBlueprint().General.BuildBones.BuildEffectBones do
		capturer.CaptureEffectsBag:Add( CreateAttachedEmitter( capturer, v, capturer:GetArmy(),  '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.08):OffsetEmitter(0,-0.05,2))
    end
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