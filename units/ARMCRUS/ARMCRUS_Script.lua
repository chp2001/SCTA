#ARM Conqueror - Cruiser
#ARMCRUS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMCRUS = Class(TASea) {
	Weapons = {
		ARM_CRUS = Class(TAweapon) {

		},
		ARMDEPTHCHARGE = Class(TAweapon) {},
	},
}

TypeClass = ARMCRUS
