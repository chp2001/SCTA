local oldARMAWAC = ARMAWAC
ARMAWAC = Class(oldARMAWAC) { 

	OnStopBeingBuilt = function(self,builder,layer)
		oldARMAWAC.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_JammingToggle', true)
        self:RequestRefreshUI()
	end,
}

TypeClass = ARMAWAC
