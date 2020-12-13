#CORE Aircraft Plant - Produces Aircraft
#CORAP
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

CORAP = Class(TAFactory) {
	OnCreate = function(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
	self.AnimManip = CreateAnimator(self)
	self.Trash:Add(self.AnimManip)
	TAFactory.OnCreate(self)
	end,
	
	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.Spinners.dish:SetSpeed(150)
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

TypeClass = CORAP