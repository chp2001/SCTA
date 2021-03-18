#ARM Crusader - Destroyer
#ARMROY
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMROY = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {
		},
	},
}

TypeClass = ARMROY
