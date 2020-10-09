local oldCORSY = CORSY
CORSY = Class(oldCORSY) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldCORSY.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = CORSY