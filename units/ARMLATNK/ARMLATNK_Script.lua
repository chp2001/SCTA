#ARM Panther - Lightning Tank
#ARMLATNK
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMLATNK = Class(TACounter) {
	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = ARMLATNK
