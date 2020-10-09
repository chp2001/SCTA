local oldCORMEX = CORMEX
CORMEX = Class(oldCORMEX) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldCORMEX.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = CORMEX