local oldARMAWAC = ARMAWAC
ARMAWAC = Class(oldARMAWAC) {
	OnStopBeingBuilt = function(self)
		self:SetMaintenanceConsumptionActive()
		oldARMAWAC.OnStopBeingBuilt(self)
end
} 
TypeClass = ARMAWAC