#ARM Colossus - Light Carrier
#ARMCARRY
#
#Script created by Raevn

local TACarrier = import('/mods/SCTA-master/lua/TAFactory.lua').TACarrier

ARMCARRY = Class(TACarrier) {
	OnCreate = function(self)
		TACarrier.OnCreate(self)
		self.Spinners = {
			radar = CreateRotator(self, 'Radar', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACarrier.OnStopBeingBuilt(self,builder,layer)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
		--SPIN dish around y-axis SPEED <60.01>
		self.Spinners.radar:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
		ChangeState(self, self.IdleState)
	end,

	OnIntelDisabled = function(self)
			self.Spinners.radar:SetSpeed(0)
			self:SetMaintenanceConsumptionInactive()
		TACarrier.OnIntelDisabled(self)
	end,


	OnIntelEnabled = function(self)
			self.Spinners.radar:SetSpeed(60)
			self:SetMaintenanceConsumptionActive()
		TACarrier.OnIntelEnabled(self)
	end,

	BuildAttachBone = 'Attachpoint_Med_01',
}

TypeClass = ARMCARRY
