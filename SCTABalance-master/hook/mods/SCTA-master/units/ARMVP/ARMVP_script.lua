local oldARMVP = ARMVP
ARMVP = Class(oldARMVP) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldARMVP.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = ARMVP