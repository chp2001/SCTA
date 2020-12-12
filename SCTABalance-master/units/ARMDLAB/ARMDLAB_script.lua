#ARM Kbot Lab - Produces Kbots
#ARMDLAB
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

ARMDLAB = Class(TAFactory) {
	pauseTime = 5,
	hideUnit = true,


	OnCreate = function(self)
		self.Spinners = {
			pad = CreateRotator(self, 'BasePlate', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
		TAFactory.OnCreate(self)
	end,


	Open = function(self)
		TAFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		WaitSeconds(0.6)
		self.Spinners.pad:SetSpeed(0)
	end,

	Aim = function(self, target)
		TAFactory.Aim(self, target)
		WaitFor(self.AnimManip)
	end,

	Close = function(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-0.1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		self.Spinners.pad:SetSpeed(0)
		WaitSeconds(0.4)
		ChangeState(self, self.IdleState)
		TAFactory.Close(self)
	end,


}

TypeClass = ARMDLAB