#ARM Guardian - Plasma Battery
#ARMGUARD
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMGUARD = Class(TAStructure) {
	Weapons = {
		ARMFIXED_GUN = Class(TAweapon) {

		},
	},
}

TypeClass = ARMGUARD
