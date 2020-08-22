local oldCORASON = CORASON
CORASON = Class(oldCORASON) {
	 OnStopBeingBuilt = function(self,builder,layer)
		oldCORASON.OnStopBeingBuilt(self,builder,layer)
		self:PlayUnitSound('Activate')
		TAutils.registerTargetingFacility(self:GetArmy())
	end,
}

TypeClass = CORASON