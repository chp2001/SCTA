#ARM Flakker - Anti-Air Flak Gun
#ARMFLAK
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMFLAK = Class(TAStructure) {
	Weapons = {
		ARMFLAK_GUN = Class(TAweapon) {},
	},
}

TypeClass = ARMFLAK
