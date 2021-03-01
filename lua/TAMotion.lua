local Unit = import('/lua/sim/Unit.lua').Unit
local explosion = import('/lua/defaultexplosions.lua')
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local util = import('/lua/utilities.lua')

TATreads = Class(TAunit) 
{
}

TAWalking = Class(TATreads) 
{
    WalkingAnim = nil,
    WalkingAnimRate = 1,
    IdleAnim = false,
    IdleAnimRate = 1,
    DeathAnim = nil,
    DisabledBones = {},

    OnMotionHorzEventChange = function( self, new, old )
        ---self:LOGDBG('TAWalking.OnMotionHorzEventChange')
        TATreads.OnMotionHorzEventChange(self, new, old)
       
        if ( old == 'Stopped' ) then
            if (not self.Animator) then
                self.Animator = CreateAnimator(self, true)
            end
            local bpDisplay = self:GetBlueprint().Display
            if bpDisplay.AnimationWalk then
                self.Animator:PlayAnim(bpDisplay.AnimationWalk, true)
                self.Animator:SetRate(bpDisplay.AnimationWalkRate or 1)
                TATreads.CreateMovementEffects(self)
            end
        elseif ( new == 'Stopped' ) then
                TATreads.CreateMovementEffects(self)
            if(self.IdleAnim and not self:IsDead()) then
                self.Animator:PlayAnim(self.IdleAnim, true)
            elseif(not self.DeathAnim or not self:IsDead()) then
                self.Animator:Destroy()
                self.Animator = false
            end
        end
    end,

    OnKilled = function(self, instigator, type, overkillRatio)
        ---self:LOGDBG('TAWalking.OnKilled')
		TATreads.OnKilled(self, instigator, type, overkillRatio)
	end,
}

TACloaker = Class(TAWalking) {
    OnMotionHorzEventChange = function(self, new, old )
		TAWalking.OnMotionHorzEventChange(self, new, old)
        if self.TAIntelOn then
            if  self:IsUnitState('Moving') then
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.TAConsumptionPerSecondEnergy)
            else
                self:SetConsumptionPerSecondEnergy(self:GetBlueprint().Economy.MaintenanceConsumptionPerSecondEnergy)
            end
        end
    end,
}