local oldCORPLAT = CORPLAT
CORPLAT = Class(oldCORPLAT) {
    OnCreate = function(self)
        oldCORPLAT.OnCreate(self)
        self:AddBuildRestriction( categories.CORE * (categories.TECH1 + categories.TECH2) )
    end,
}

TypeClass = CORPLAT