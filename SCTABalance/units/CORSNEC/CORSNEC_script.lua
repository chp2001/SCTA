#CORE Construction Ship - Tech Level 1
#CORCS
#
#Script created by Raevn

local TANecro = import('/mods/SCTA-master/lua/TAconstructor.lua').TANecro
local TAutils = import('/mods/SCTA-master/lua/TAutils.lua')

CORCSNEC = Class(TANecro) {
    OnCreate = function(self)
        TANecro.OnCreate(self)
        self:AddBuildRestriction(categories.CYBRAN)
        end,
}

TypeClass = CORCSNEC