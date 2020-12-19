#CORE Hive - Light Carrier
#CORCARRY
#
#Script created by Raevn

local TACarrier = import('/mods/SCTA-master/lua/TAFactory.lua').TACarrier

CORCARRY = Class(TACarrier) {
	OnCreate = function(self)
		TACarrier.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
    end,
    
    OnIntelDisabled = function(self)
		self.Spinners.dish:SetSpeed(0)
		self:SetMaintenanceConsumptionInactive()
	    TACarrier.OnIntelDisabled(self)
end,


    OnIntelEnabled = function(self)
		self.Spinners.dish:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
	    TACarrier.OnIntelEnabled(self)
end,

	OnStopBeingBuilt = function(self,builder,layer)
		TACarrier.OnStopBeingBuilt(self,builder,layer)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
		--SPIN dish around y-axis SPEED <60.01>
		self.Spinners.dish:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
        ChangeState(self, self.IdleState)
    end,
}



TypeClass = CORCARRY
