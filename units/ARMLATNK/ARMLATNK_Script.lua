#ARM Panther - Lightning Tank
#ARMLATNK
#
#Script created by Raevn

local TABACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TABACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMLATNK = Class(TABACounter) {
	Weapons = {
		ARMKBOT_MISSILE = Class(TAweapon) {},
		ARMLATNK_WEAPON = Class(TAweapon) {},
	},
}

TypeClass = ARMLATNK
