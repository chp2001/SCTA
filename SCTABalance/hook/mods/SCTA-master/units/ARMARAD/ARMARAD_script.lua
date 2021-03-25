local oldARMARAD = ARMARAD

ARMARAD = Class(oldARMARAD) {

	 OnFailedToBuild = function(self)
        oldARMARAD.OnFailedToBuild(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
		ChangeState(self, self.OpeningState)
	end,
}

TypeClass = ARMARAD