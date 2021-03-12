#ARM FARK - Fast Assist-Repair Kbot
#ARMFARK
#
#Script created by Raevn

local TANecro = import('/mods/SCTA-master/lua/TAconstructor.lua').TANecro


CORNECRO = Class(TANecro) {
    OnCreate = function(self)
        TANecro.OnCreate(self)
        if not __blueprints['armgant'] then
        self:AddBuildRestriction(categories.CORE)
        end
        end,
}	

TypeClass = CORNECRO