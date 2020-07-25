local oldARMARAD = ARMARAD
ARMARAD = Class(oldARMARAD) {
	OnStopBuild = function(self, unitBuilding)
		 oldARMARAD.OnStopBuild(self, unitBuilding)
		 if unitBuilding:GetFractionComplete() == 1 and unitBuilding:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBuilding)
			 self:Destroy()
		 end
	 end,

	 OnFailedToBuild = function(self)
        oldARMARAD.OnFailedToBuild(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
		ChangeState(self, self.OpeningState)
    end,
}

TypeClass = ARMARAD