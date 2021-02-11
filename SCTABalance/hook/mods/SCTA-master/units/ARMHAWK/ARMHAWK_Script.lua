local oldARMHAWK = ARMHAWK
ARMHAWK = Class(oldARMHAWK) {
	OnStopBeingBuilt = function(self, builder, layer)
		self:SetMaintenanceConsumptionActive()
		oldARMHAWK.OnStopBeingBuilt(self, builder, layer)
end,
}
TypeClass = ARMHAWK