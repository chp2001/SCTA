local oldCORLAB = CORLAB
CORLAB = Class(oldCORLAB) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldCORLAB.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = CORLAB