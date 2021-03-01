#ARM Anaconda - Hovertank
#ARMANAC
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMAH = Class(TAunit) {

	Weapons = {
		ARMANAC_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = ARMAH
