#CORE Enforcer - Destroyer
#CORROY
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORROY = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {
		},
	},
}

TypeClass = CORROY
