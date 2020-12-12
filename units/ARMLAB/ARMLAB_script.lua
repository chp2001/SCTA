#ARM Kbot Lab - Produces Kbots
#ARMLAB
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAfactory.lua').TAFactory

ARMLAB = Class(TAFactory) {
	OnCreate = function(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAFactory.OnCreate(self)
	end,


	Open = function(self)
		TAFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,


	Close = function(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))

		TAFactory.Close(self)
	end,
}

TypeClass = ARMLAB