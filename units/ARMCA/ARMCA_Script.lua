#ARM Construction Aircraft - Tech Level 1
#ARMCA
#
#Script created by Raevn

local TAAirConstructor = import('/mods/SCTA-master/lua/TAAirConstructor.lua').TAAirConstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMCA = Class(TAAirConstructor) {
	OnCreate = function(self)
		TAAirConstructor.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnMotionVertEventChange = function(self, new, old )
		if (new == 'Down' or new == 'Bottom') then
                	self:PlayUnitSound('Landing')
			self:CloseWings(self)
		elseif (new == 'Up' or new == 'Top') then
                	self:PlayUnitSound('TakeOff')
			self:OpenWings(self)
		end
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAAirConstructor.OnStopBeingBuilt(self,builder,layer)
		self:OpenWings(self)
	end,

	OpenWings = function(self)
		--MOVE wing1 to x-axis <5.59> SPEED <5.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,

	CloseWings = function(self)
		--MOVE wing1 to x-axis <0> SPEED <4.00>;
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationWing)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationWingRate or 0.2))
	end,
}

TypeClass = ARMCA