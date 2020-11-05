local oldARMPLAT = ARMPLAT
ARMPLAT = Class(oldARMPLAT) {
    OnCreate = function(self)
        oldARMPLAT.OnCreate(self)
        self:AddBuildRestriction( categories.ARM * (categories.SEAPLA) )
    end,
}

TypeClass = ARMPLAT