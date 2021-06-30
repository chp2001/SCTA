#ARM Sentinel - Heavy Laser Tower
#ARMHLT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMHLT = Class(TAStructure) {
	Weapons = {
		ARM_LASERH1 = Class(TAweapon) {},
	},
}

TypeClass = ARMHLT
