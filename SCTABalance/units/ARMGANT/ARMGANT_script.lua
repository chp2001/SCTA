#ARM Drake Gantry - Builds Drake
#ARMGANT
#
#Script created by Raevn

local TAGantry = import('/mods/SCTA-master/lua/TAFactory.lua').TAGantry
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMGANT = Class(TAGantry) {
	OnCreate = function(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAGantry.OnCreate(self)
	end,


	Open = function(self)
		TAGantry.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,


	Close = function(self)
		TAGantry.Close(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
	end,
}

TypeClass = ARMGANT