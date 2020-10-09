local oldARMLAB = ARMLAB
ARMLAB = Class(oldARMLAB) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldARMLAB.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = ARMLAB