local oldCORVAMP = CORVAMP
CORVAMP = Class(oldCORVAMP) {
	OnStopBeingBuilt = function(self, builder, layer)
	self:SetMaintenanceConsumptionActive()
	oldCORVAMP.OnStopBeingBuilt(self, builder, layer)	
	end,
}

TypeClass = CORVAMP