local Unit = import('/lua/sim/Unit.lua').Unit
local explosion = import('/lua/defaultexplosions.lua')
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local util = import('/lua/utilities.lua')
local debrisCat = import('/mods/SCTA-master/lua/TAdebrisCategories.lua')


TATreads = Class(TAunit) 
{

MovementEffects = function( self, EffectsBag, TypeSuffix)
    local layer = self:GetCurrentLayer()
    local bpTable = self:GetBlueprint().Display.MovementEffects

    if bpTable[layer] then
        bpTable = bpTable[layer]
        if bpTable.Treads then
            self:CreateTreads( bpTable.Treads )
        else
            self:RemoveScroller()
        end
    end
end,

CreateMotionChangeEffects = function( self, new, old )
    local key = self:GetCurrentLayer()..old..new
    local bpTable = self:GetBlueprint().Display.MotionChangeEffects[key]

    if bpTable then
        self:CreateTerrainTypeEffects( bpTable.Effects, 'FXMotionChange', key )
    end
end,

DestroyMovementEffects = function( self )
    local bpTable = self:GetBlueprint().Display.MovementEffects
    local layer = self:GetCurrentLayer()

    # Cleanup treads
    if self.TreadThreads then
        for k, v in self.TreadThreads do
            KillThread(v)
        end
        self.TreadThreads = {}
    end
    if bpTable[layer].Treads.ScrollTreads then
        self:RemoveScroller()
    end
end,

DestroyTopSpeedEffects = function( self )
    EffectUtilities.CleanupEffectBag(self,'TopSpeedEffectsBag')
end,

DestroyIdleEffects = function( self )
    EffectUtilities.CleanupEffectBag(self,'IdleEffectsBag')
end,

UpdateBeamExhaust = function( self, motionState )
    local bpTable = self:GetBlueprint().Display.MovementEffects.BeamExhaust
    if not bpTable then
        return false
    end

    if motionState == 'Idle' then
        if self.BeamExhaustCruise  then
            self:DestroyBeamExhaust()
        end
        if self.BeamExhaustIdle and (table.getn(self.BeamExhaustEffectsBag) == 0) and (bpTable.Idle != false) then
            self:CreateBeamExhaust( bpTable, self.BeamExhaustIdle )
        end
    elseif motionState == 'Cruise' then
        if self.BeamExhaustIdle and self.BeamExhaustCruise then
            self:DestroyBeamExhaust()
        end
        if self.BeamExhaustCruise and (bpTable.Cruise != false) then
            self:CreateBeamExhaust( bpTable, self.BeamExhaustCruise )
        end
    elseif motionState == 'Landed' then
        if not bpTable.Landed then
            self:DestroyBeamExhaust()
        end
    end
end,

CreateBeamExhaust = function( self, bpTable, beamBP )
    local effectBones = bpTable.Bones
    if not effectBones or (effectBones and (table.getn(effectBones) == 0)) then
        LOG('*WARNING: No beam exhaust effect bones defined for unit ',repr(self:GetUnitId()),', Effect Bones must be defined to play beam exhaust effects. Add these to the Display.MovementEffects.BeamExhaust.Bones table in unit blueprint.' )
        return false
    end
    local army = self:GetArmy()
    for kb, vb in effectBones do
        table.insert( self.BeamExhaustEffectsBag, CreateBeamEmitterOnEntity(self, vb, army, beamBP ))
    end
end,


CreateTreads = function(self, treads)
    if treads.ScrollTreads then
        self:AddThreadScroller(1.0, treads.ScrollMultiplier or 0.2)
    end
    self.TreadThreads = {}
    if treads.TreadMarks then
        local type = self:GetTTTreadType(self:GetPosition())
        if type != 'None' then
            for k, v in treads.TreadMarks do
                table.insert( self.TreadThreads, self:ForkThread(self.CreateTreadsThread, v, type ))
            end
        end
    end
end,

CreateTreadsThread = function(self, treads, type )
    local sizeX = treads.TreadMarksSizeX
    local sizeZ = treads.TreadMarksSizeZ
    local interval = treads.TreadMarksInterval
    local treadOffset = treads.TreadOffset
    local treadBone = treads.BoneName or 0
    local treadTexture = treads.TreadMarks
    local duration = treads.TreadLifeTime or 10
    local army = self:GetArmy()

    while true do
        # Syntatic reference
        # CreateSplatOnBone(entity, offset, boneName, textureName, sizeX, sizeZ, lodParam, duration, army)
        CreateSplatOnBone(self, treadOffset, treadBone, treadTexture, sizeX, sizeZ, 130, duration, army)
        WaitSeconds(interval)
    end
end,
}