local oldARMSY = ARMSY
ARMSY = Class(oldARMSY) {
       OnStopBuild = function(self, unitBeingBuilt)
            oldARMSY.OnStopBuild(self, unitBeingBuilt)
            if unitBeingBuilt:GetFractionComplete() == 1 and unitBeingBuilt:GetUnitId() == self:GetBlueprint().General.UpgradesTo then
                NotifyUpgrade(self, unitBeingBuilt)
                self:Destroy()
            end
        end,
}

TypeClass = ARMSY