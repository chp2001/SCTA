local oldCORAWAC = CORAWAC
CORAWAC = Class(oldCORAWAC) { 

	OnStopBeingBuilt = function(self,builder,layer)
		oldCORAWAC.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_JammingToggle', true)
        self:RequestRefreshUI()
	end,
}

TypeClass = CORAWAC
