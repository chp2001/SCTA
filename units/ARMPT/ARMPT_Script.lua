#ARM Skeeter - Scout Ship
#ARMPT
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMPT = Class(TAunit) {
	Weapons = {
		ARMPT_LASER = Class(TAweapon) {

		},
		ARMKBOT_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = ARMPT
