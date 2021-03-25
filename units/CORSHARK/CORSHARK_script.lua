#CORE Shark - Submarine Killer
#CORSHARK
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSHARK = Class(TASea) {
    Weapons = {
        CORSMART_TORPEDO = Class(TAweapon) {
	},
    },
}


TypeClass = CORSHARK