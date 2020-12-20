#ARM Shipyard - Produces Ships
#ARMDSY
#
#Script created by Raevn

local TASeaFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TASeaFactory

ARMDSY = Class(TASeaFactory) {
	OnCreate = function(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TASeaFactory.OnCreate(self)
	end,


	Open = function(self)
		TASeaFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,


	Close = function(self)
		TASeaFactory.Close(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,

}

TypeClass = ARMDSY