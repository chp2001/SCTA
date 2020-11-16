local oldCORPLAT = CORPLAT
CORPLAT = Class(oldCORPLAT) {
    OnCreate = function(self)
        oldCORPLAT.OnCreate(self)
        self:AddBuildRestriction( categories.CORE * (categories.SEAPLA) )
    end,
}

TypeClass = CORPLAT