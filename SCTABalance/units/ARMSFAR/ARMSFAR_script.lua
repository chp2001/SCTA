#ARM Construction Ship - Tech Level 1
#ARMCS
#
#Script created by Raevn

local TAconstructor = import('/mods/SCTA-master/lua/TAconstructor.lua').TAconstructor
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

ARMSFAR = Class(TAconstructor) {
    OnCreate = function(self)
        TAconstructor.OnCreate(self)
        self:AddBuildRestriction(categories.CYBRAN)
        end,
}

TypeClass = ARMSFAR