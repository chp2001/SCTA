#COR Snake - Submarine
#CORSUB
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSUB = Class(TAunit) {
    Weapons = {
        CORE_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = CORSUB