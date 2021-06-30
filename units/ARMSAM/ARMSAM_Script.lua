#ARM Samson - Mobile Missile Launcher
#ARMSAM
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSAM = Class(TAunit) {
	Weapons = {
		ARMTRUCK_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = ARMSAM
