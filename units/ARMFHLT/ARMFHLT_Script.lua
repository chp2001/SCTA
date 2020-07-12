#ARM Stingray - Floating Heavy Laser Tower
#ARMFHLT
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMFHLT = Class(TAunit) {
	Weapons = {
		ARMFHLT_LASER = Class(TAweapon) {},
	},
}

TypeClass = ARMFHLT
