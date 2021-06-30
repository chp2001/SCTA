#ARM Anaconda - Hovertank
#ARMANAC
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMANAC = Class(TASea) {

	Weapons = {
		ARMANAC_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = ARMANAC
