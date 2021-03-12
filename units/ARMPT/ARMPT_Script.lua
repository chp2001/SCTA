#ARM Skeeter - Scout Ship
#ARMPT
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMPT = Class(TASea) {
	Weapons = {
		ARMPT_LASER = Class(TAweapon) {

		},
		ARMKBOT_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = ARMPT
