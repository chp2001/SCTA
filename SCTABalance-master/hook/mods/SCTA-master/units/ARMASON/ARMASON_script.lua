local oldARMASON = ARMASON
ARMASON = Class(oldARMASON) {
	 OnStopBeingBuilt = function(self,builder,layer)
		oldARMASON.OnStopBeingBuilt(self,builder,layer)
		self:PlayUnitSound('Activate')
		TAutils.registerTargetingFacility(self:GetArmy())
	end,
}

TypeClass = ARMASON