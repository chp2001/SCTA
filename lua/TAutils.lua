local util = import('/lua/utilities.lua')
local EffectUtil = import('/lua/EffectUtilities.lua')

CreateTABuildingEffects = function( self, unitBeingBuilt, order )
	WaitSeconds( 0.1 )
	for k, v in self:GetBlueprint().General.BuildBones.BuildEffectBones do
		self.BuildEffectsBag:Add( CreateAttachedEmitter( self, v, self:GetArmy(), '/mods/SCTA-master/effects/emitters/nanolathe.bp' ):ScaleEmitter(0.1) )         
	end
end

function CreateDefaultBuildBeams( builder, unitBeingBuilt, BuildEffectBones, BuildEffectsBag )
    local BeamBuildEmtBp = '/mods/SCTA-master/effects/emitters/nanolathe.bp'
    local ox, oy, oz = unpack(unitBeingBuilt:GetPosition())
    local BeamEndEntity = Entity()
    local army = builder:GetArmy()
    BuildEffectsBag:Add( BeamEndEntity )
    Warp( BeamEndEntity, Vector(ox, oy, oz))   
   
    local BuildBeams = {}

    # Create build beams
    if BuildEffectBones != nil then
        local beamEffect = nil
        for i, BuildBone in BuildEffectBones do
            local beamEffect = AttachBeamEntityToEntity(builder, BuildBone, BeamEndEntity, -1, army, BeamBuildEmtBp )
            table.insert( BuildBeams, beamEffect )
            BuildEffectsBag:Add(beamEffect)
        end
    end
    
    CreateEmitterOnEntity( BeamEndEntity, builder:GetArmy(),'/effects/emitters/sparks_08_emit.bp')
    local waitTime = util.GetRandomFloat( 0.3, 1.5 )

    while not builder:BeenDestroyed() and not unitBeingBuilt:BeenDestroyed() do
        local x, y, z = builder.GetRandomOffset(unitBeingBuilt, 1 )
        Warp( BeamEndEntity, Vector(ox + x, oy + y, oz + z))
        WaitSeconds(waitTime)
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