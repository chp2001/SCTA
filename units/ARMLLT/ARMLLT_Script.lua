#ARM L.L.T. - Light Laser Tower
#ARMLLT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMLLT = Class(TAStructure) {
	Weapons = {
		ARM_LIGHTLASER = Class(TAweapon) {

		},
	},
}

TypeClass = ARMLLT
