local oldCORSONAR = CORSONAR
CORSONAR = Class(oldCORSONAR) {
	OnStopBuild = function(self, unitBuilding)
		 oldCORSONAR.OnStopBuild(self, unitBuilding)
		 if unitBuilding:GetFractionComplete() == 1 and unitBuilding:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBuilding)
			 self:Destroy()
		 end
	 end,
}

TypeClass = CORSONAR