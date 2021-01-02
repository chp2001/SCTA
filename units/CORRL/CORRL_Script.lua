#CORE Pulverizer - Missile Tower
#CORRL
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORRL = Class(TAStructure) {

	Weapons = {
		CORRL_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = CORRL
