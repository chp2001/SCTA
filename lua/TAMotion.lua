local Unit = import('/lua/sim/Unit.lua').Unit
local explosion = import('/lua/defaultexplosions.lua')
local scenarioUtils = import('/lua/sim/ScenarioUtilities.lua')
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')
local Game = import('/lua/game.lua')
local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local util = import('/lua/utilities.lua')

TASea = Class(TAunit) 
{
    OnCreate = function(self)
        TAunit.OnCreate(self)
		self.FxMovement = TrashBag()
        end,

     
	OnMotionHorzEventChange = function(self, new, old )
		TAunit.OnMotionHorzEventChange(self, new, old)
		self.CreateMovementEffects(self)
	end,
    
    
	CreateMovementEffects = function(self, EffectsBag, TypeSuffix)
		if not IsDestroyed(self) then
		TAunit.CreateMovementEffects(self, EffectsBag, TypeSuffix)
		local bp = self:GetBlueprint()
		if self:IsUnitState('Moving') and bp.Display.MovementEffects.TAMovement then
			for k, v in bp.Display.MovementEffects.TAMovement.Bones do
				self.FxMovement:Add(CreateAttachedEmitter(self, v, self:GetArmy(), bp.Display.MovementEffects.TAMovement.Emitter ):ScaleEmitter(bp.Display.MovementEffects.TAMovement.Scale))
			end
			elseif not self:IsUnitState('Moving') then
			for k,v in self.FxMovement do
				v:Destroy()
			end
		end
		end
	end,


}
TAWalking = Class(TAunit) 
{
    WalkingAnim = nil,
    WalkingAnimRate = 1,
    IdleAnim = false,
    IdleAnimRate = 1,
    DeathAnim = nil,
    DisabledBones = {},

    OnMotionHorzEventChange = function( self, new, old )
        ---self:LOGDBG('TAWalking.OnMotionHorzEventChange')
        TAunit.OnMotionHorzEventChange(self, new, old)
        if ( old == 'Stopped' ) then
            if (not self.Animator) then
                self.Animator = CreateAnimator(self, true)
            end
            local bpDisplay = self:GetBlueprint().Display
            if bpDisplay.AnimationWalk then
                self.Animator:PlayAnim(bpDisplay.AnimationWalk, true)
                self.Animator:SetRate(bpDisplay.AnimationWalkRate or 1)
            end
        elseif ( new == 'Stopped' ) then
            if(self.IdleAnim and not self:IsDead()) then
                self.Animator:PlayAnim(self.IdleAnim, true)
            elseif(not self.DeathAnim or not self:IsDead()) then
                self.Animator:Destroy()
                self.Animator = false
            end
        end
    end,
}