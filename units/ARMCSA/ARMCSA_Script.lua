#ARM Adv. Construction Aircraft - Tech Level 2
#ARMACA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor


ARMCSA = Class(TAAirConstructor) {
	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,


	OpenWings = function(self)
		--MOVE wing1 to x-axis <5.59> SPEED <5.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <5.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,

}

TypeClass = ARMCSA