#CORE Spectre - Radar Jammer
#CORSPEC
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter


CORSPEC = Class(TACounter) {
	OnCreate = function(self)
		TACounter.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'tongspivot', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	Close = function(self)
		self:PlayUnitSound('Deactivate')
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPack)
		self.AnimManip:SetRate((self:GetBlueprint().Display.AnimationPackRate or 1))
		--WaitFor(self.AnimManip)
		--self.Spinners.fork:SetGoal(0)
		--self.Spinners.fork:SetSpeed(0)
	end,

	Open = function(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 1))
		---WaitFor(self.AnimManip)
		---self.Spinners.fork:SetSpeed(50)
		self:PlayUnitSound('Activate')
	end,

	OnIntelDisabled = function(self)
		TACounter.OnIntelDisabled(self)
		ForkThread(self.Close, self)
	end,

	OnIntelEnabled = function(self)
		TACounter.OnIntelEnabled(self)
		ForkThread(self.Open, self)
	end,
}
TypeClass = CORSPEC