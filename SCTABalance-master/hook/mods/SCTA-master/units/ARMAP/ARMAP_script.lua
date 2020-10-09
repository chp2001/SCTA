local oldARMAP = ARMAP
ARMAP = Class(oldARMAP) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldARMAP.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = ARMAP