local oldCORRAD = CORRAD
CORRAD = Class(oldCORRAD) {
	OnStopBuild = function(self, unitBeingBuilt)
		 oldCORRAD.OnStopBuild(self, unitBeingBuilt)
		 if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
			 NotifyUpgrade(self, unitBeingBuilt)
			 self:Destroy()
		 end
	 end,
}

TypeClass = CORRAD