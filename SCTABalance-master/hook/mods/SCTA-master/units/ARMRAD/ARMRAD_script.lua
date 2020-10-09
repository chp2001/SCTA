local oldARMRAD = ARMRAD
ARMRAD = Class(oldARMRAD) {
	OnStopBuild = function(self, unitBeingBuilt)
		 oldARMRAD.OnStopBuild(self, unitBeingBuilt)
		 if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBeingBuilt)
			 self:Destroy()
		 end
	 end,
}

TypeClass = ARMRAD