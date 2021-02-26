#ARM Panther - Lightning Tank
#ARMLATNK
#
#Script created by Raevn

local TACloaker = import('/mods/SCTA-master/lua/TAMotion.lua').TACloaker
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMLATNK = Class(TACloaker) {
	Weapons = {
		ARMKBOT_MISSILE = Class(TAweapon) {},
		ARMLATNK_WEAPON = Class(TAweapon) {},
	},
}

TypeClass = ARMLATNK
