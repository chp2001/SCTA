local util = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')
local Entity = import('/lua/sim/Entity.lua').Entity
local EffectTemplate = import('/lua/EffectTemplates.lua')

CreateTABuildingEffects = function( self, unitBeingBuilt, order )
	WaitSeconds( 0.1 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
	end
end


CreateTAFactBuildingEffects = function( self, unitBeingBuilt, order )
	WaitSeconds( 0.1 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.05) )         
    end
end

CreateTAGantBuildingEffects = function( self, unitBeingBuilt, order )
	WaitSeconds( 0.1 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.2) )         
    end
end

TAReclaimEffects = function(reclaimer, reclaimed, BuildEffectBones, EffectsBag)
    EffectUtil.PlayReclaimEffects( reclaimer, reclaimed, BuildEffectBones, EffectsBag )
    local target = reclaimed
    for k, v in target do
        reclaimed.ReclaimEffectsBag:Add( CreateAttachedEmitter(reclaimed, 0, reclaimer:GetArmy(), '/mods/SCTA-master/effects/emitters/reclaimnanolathe.bp' ):ScaleEmitter(0.08) )
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