#CORE Intimidator - Long Range Plasma Cannon
#CORINT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORINT = Class(TAStructure) {
	Weapons = {
		CORE_INTIMIDATOR = Class(TAweapon) {
		},
	},
}

TypeClass = CORINT
