#CORE Spectre - Radar Jammer
#CORSPEC
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking


CORSPEC = Class(TAWalking) {
	OnCreate = function(self)
		TAWalking.OnCreate(self)
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	Close = function(self)
		self:PlayUnitSound('Deactivate')
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
        WaitFor(self.AnimManip)
		self:SetMaintenanceConsumptionInactive()
	end,

	Open = function(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationUnpack)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationUnpackRate or 0.2))
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
	end,

	OnIntelDisabled = function(self)
		TAWalking.OnIntelDisabled(self)
		ForkThread(self.Close, self)
	end,

	OnIntelEnabled = function(self)
		TAWalking.OnIntelEnabled(self)
		ForkThread(self.Open, self)
		
	end,
}
TypeClass = CORSPEC