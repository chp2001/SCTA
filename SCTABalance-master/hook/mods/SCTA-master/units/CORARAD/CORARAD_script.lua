local oldCORARAD = CORARAD
CORARAD = Class(oldCORARAD) {
	OnStopBuild = function(self, unitBuilding)
		 oldCORARAD.OnStopBuild(self, unitBuilding)
		 if unitBuilding:GetFractionComplete() == 1 and unitBuilding:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBuilding)
			 self:Destroy()
		 end
	 end,

	 OnFailedToBuild = function(self)
        oldCORARAD.OnFailedToBuild(self)
		self:SetMaintenanceConsumptionActive()
		self:PlayUnitSound('Activate')
		ChangeState(self, self.OpeningState)
    end,
}

TypeClass = CORARAD