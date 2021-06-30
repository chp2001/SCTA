#COR Snake - Submarine
#CORSUB
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSUB = Class(TASea) {
    Weapons = {
        CORE_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = CORSUB