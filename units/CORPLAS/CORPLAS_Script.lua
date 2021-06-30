#CORE Immolator - Plasma Tower
#CORPLAS
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORPLAS = Class(TAStructure) {
	Weapons = {
		CORPLAS_WEAPON = Class(TAweapon) {}
	},
}

TypeClass = CORPLAS
