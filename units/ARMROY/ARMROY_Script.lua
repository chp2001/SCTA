#ARM Crusader - Destroyer
#ARMROY
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMROY = Class(TAunit) {
	Weapons = {
		ARM_ROY = Class(TAweapon) {

		},
		ARMDEPTHCHARGE = Class(TAweapon) {},
	},
}

TypeClass = ARMROY
