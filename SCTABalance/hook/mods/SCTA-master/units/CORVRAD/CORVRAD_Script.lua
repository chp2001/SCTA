local oldCORVRAD = CORVRAD
CORVRAD = Class(oldCORVRAD) { 

	OnStopBeingBuilt = function(self,builder,layer)
		oldCORVRAD.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_StealthToggle', true)
        self:RequestRefreshUI()
	end,
}

TypeClass = CORVRAD
