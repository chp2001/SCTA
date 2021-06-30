#ARM Pirahna - Submarine Killer
#ARMSUBK
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSUBK = Class(TASea) {
    Weapons = {
        ARMSMART_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = ARMSUBK