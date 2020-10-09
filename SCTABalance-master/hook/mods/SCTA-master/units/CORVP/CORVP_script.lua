local oldCORVP = CORVP

CORVP = Class(oldCORVP) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldCORVP.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = CORVP