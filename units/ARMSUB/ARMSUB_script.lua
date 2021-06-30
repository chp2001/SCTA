#ARM Lurker - Submarine
#ARMCRUS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSUB = Class(TASea) {
    Weapons = {
        ARM_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = ARMSUB