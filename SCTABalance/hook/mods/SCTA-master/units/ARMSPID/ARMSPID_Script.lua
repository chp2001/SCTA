local oldARMSPID = ARMSPID
ARMSPID = Class(oldARMSPID) { 

	OnStopBeingBuilt = function(self,builder,layer)
		oldARMSPID.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_JammingToggle', true)
        self:RequestRefreshUI()
	end,
}

TypeClass = ARMSPID
