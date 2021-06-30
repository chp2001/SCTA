local oldCORARAD = CORARAD

CORARAD = Class(oldCORARAD) {
	 OnFailedToBuild = function(self)
        oldCORARAD.OnFailedToBuild(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
		ChangeState(self, self.OpeningState)
	end,
}

TypeClass = CORARAD