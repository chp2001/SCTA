#CORE Shark - Submarine Killer
#CORSHARK
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSHARK = Class(TAunit) {
    Weapons = {
        CORSMART_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = CORSHARK