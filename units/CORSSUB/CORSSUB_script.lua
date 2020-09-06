#ARM Pirahna - Submarine Killer
#ARMSUBK
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSSUB = Class(TAunit) {
    Weapons = {
        ARMSMART_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = CORSSUB