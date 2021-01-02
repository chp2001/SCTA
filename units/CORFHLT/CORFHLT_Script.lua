#ARM Stingray - Floating Heavy Laser Tower
#ARMFHLT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORFHLT = Class(TAStructure) {
	Weapons = {
		CORFHLT_LASER = Class(TAweapon) {},
	},
}

TypeClass = CORFHLT
