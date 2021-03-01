#CORE Deleter - Mobile Radar Jammer
#CORETER
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit

CORETER = Class(TAunit) {
	OnCreate = function(self)
		TAunit.OnCreate(self)
		self.Spinners = {
			fork = CreateRotator(self, 'fork', 'z', nil, 0, 0, 0),
		}
		self.Trash:Add(self.Spinners.fork)
	end,

	OnStopBeingBuilt = function(self,builder,layer)
		TAunit.OnStopBeingBuilt(self,builder,layer)
		--spin fork around z-axis speed <100>
		self.Spinners.fork:SetSpeed(100)
		self:SetMaintenanceConsumptionActive()
	end,


	OnIntelDisabled = function(self)
		self.Spinners.fork:SetSpeed(0)
			self:SetMaintenanceConsumptionInactive()
			self:PlayUnitSound('Deactivate')
	TAunit.OnIntelDisabled(self)
end,


OnIntelEnabled = function(self)
	self.Spinners.fork:SetSpeed(100)
	self:SetMaintenanceConsumptionActive()
	self:PlayUnitSound('Activate')
	TAunit.OnIntelEnabled(self)
end,
}
TypeClass = CORETER