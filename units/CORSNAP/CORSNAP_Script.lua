#COR Snapper - Hovertank
#CORSNAP
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSNAP = Class(TASea) {

	Weapons = {
		CORSNAP_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = CORSNAP
