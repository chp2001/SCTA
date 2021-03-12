#ARM Phalanx - Mobile Flak Vehicle
#ARMYORK
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMYORK = Class(TAunit) {

	Weapons = {
		ARMYORK_GUN = Class(TAweapon) {
		},
	},
}

TypeClass = ARMYORK
