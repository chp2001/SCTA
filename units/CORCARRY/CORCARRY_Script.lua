#CORE Hive - Light Carrier
#CORCARRY
#
#Script created by Raevn

local TAFactory = import('/mods/SCTA-master/lua/TAFactory.lua').TAFactory

CORCARRY = Class(TAFactory) {
	OnCreate = function(self)
		TAFactory.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 0, 0),
		}
		for k, v in self.Spinners do
			self.Trash:Add(v)
		end
		self.AnimManip = CreateAnimator(self)
		self.Trash:Add(self.AnimManip)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAFactory.OnStopBeingBuilt(self,builder,layer)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationPower)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationPowerRate or 0.2))
		--SPIN dish around y-axis SPEED <60.01>
		self.Spinners.dish:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
	end,

	Open = function(self)
		TAFactory.Open(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
	end,

	Close = function(self)
		TAFactory.Close(self)
		self.AnimManip:PlayAnim(self:GetBlueprint().Display.AnimationBuild)
		self.AnimManip:SetRate(-1 * (self:GetBlueprint().Display.AnimationBuildRate or 0.2))
	end,

	OnIntelDisabled = function(self)
		self.Spinners.dish:SetSpeed(0)
		self:SetMaintenanceConsumptionInactive()
	TAFactory.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
		self.Spinners.dish:SetSpeed(60)
		self:SetMaintenanceConsumptionActive()
	TAFactory.OnIntelEnabled(self)
end,
}

TypeClass = CORCARRY
