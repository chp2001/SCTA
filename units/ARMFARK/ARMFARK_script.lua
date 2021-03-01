#ARM FARK - Fast Assist-Repair Kbot
#ARMFARK
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor


ARMFARK = Class(TAconstructor) {
    OnCreate = function(self)
        TAconstructor.OnCreate(self)
        self:AddBuildRestriction(categories.CYBRAN)
        end,
}

TypeClass = ARMFARK