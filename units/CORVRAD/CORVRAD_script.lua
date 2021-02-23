#CORE Informer - Mobile Radar
#CORVRAD
#
#Script created by Raevn
local TATreads = import('/mods/SCTA-master/lua/TAMotion.lua').TATreads

CORVRAD = Class(TATreads) {
	OnCreate = function(self)
		TATreads.OnCreate(self)
		self.Spinners = {
			dish = CreateRotator(self, 'dish', 'y', nil, 0, 100, 0),
		}
		self.Trash:Add(self.Spinners.dish)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TATreads.OnStopBeingBuilt(self,builder,layer)
		--spin dish around y-axis speed <100>;
		self.Spinners.dish:SetTargetSpeed(100)
		self:OnIntelEnabled()
	end,


	OnIntelDisabled = function(self)
		self.Spinners.dish:SetSpeed(0)
			self:SetMaintenanceConsumptionInactive()
	TATreads.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
	self.Spinners.dish:SetSpeed(100)
	self:SetMaintenanceConsumptionActive()
	TATreads.OnIntelEnabled(self)
end,
}
TypeClass = CORVRAD