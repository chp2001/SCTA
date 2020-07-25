local oldARMSONAR = ARMSONAR
ARMSONAR = Class(oldARMSONAR) {
	OnStopBuild = function(self, unitBuilding)
		 oldARMSONAR.OnStopBuild(self, unitBuilding)
		 if unitBuilding:GetFractionComplete() == 1 and unitBuilding:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBuilding)
			 self:Destroy()
		 end
	 end,
}

TypeClass = ARMSONAR