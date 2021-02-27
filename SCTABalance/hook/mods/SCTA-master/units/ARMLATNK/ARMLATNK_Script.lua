local oldARMLATNK = ARMLATNK
ARMLATNK = Class(oldARMLATNK) { 
	OnStopBeingBuilt = function(self,builder,layer)
		oldARMLATNK.OnStopBeingBuilt(self,builder,layer)
		self:SetMaintenanceConsumptionInactive()
        self:SetScriptBit('RULEUTC_JammingToggle', true)
        self:RequestRefreshUI()
	end,
}

TypeClass = ARMLATNK
