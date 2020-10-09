local oldCORAP = CORAP
CORAP = Class(oldCORAP) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldCORAP.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = CORAP