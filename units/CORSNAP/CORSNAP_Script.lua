#COR Snapper - Hovertank
#CORSNAP
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSNAP = Class(TAunit) {

	Weapons = {
		CORSNAP_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = CORSNAP
