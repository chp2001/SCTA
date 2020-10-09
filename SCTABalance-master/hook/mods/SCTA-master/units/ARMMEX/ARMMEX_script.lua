local oldARMMEX = ARMMEX
ARMMEX = Class(oldARMMEX) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldARMMEX.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = ARMMEX