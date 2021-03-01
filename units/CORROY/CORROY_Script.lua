#CORE Enforcer - Destroyer
#CORROY
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORROY = Class(TAunit) {
	Weapons = {
		CORE_ROY = Class(TAweapon) {

		},
		COREDEPTHCHARGE = Class(TAweapon) {},
	},
}

TypeClass = CORROY
