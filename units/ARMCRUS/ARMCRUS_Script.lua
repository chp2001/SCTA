#ARM Conqueror - Cruiser
#ARMCRUS
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMCRUS = Class(TAunit) {
	Weapons = {
		ARM_CRUS = Class(TAweapon) {

		},
		ARMDEPTHCHARGE = Class(TAweapon) {},
	},
}

TypeClass = ARMCRUS
