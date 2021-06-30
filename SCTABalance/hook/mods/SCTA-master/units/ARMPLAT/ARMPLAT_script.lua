local oldARMPLAT = ARMPLAT
ARMPLAT = Class(oldARMPLAT) {
    OnCreate = function(self)
        oldARMPLAT.OnCreate(self)
        self:AddBuildRestriction( categories.ARM * (categories.TECH1 + categories.TECH2) )
    end,
}

TypeClass = ARMPLAT