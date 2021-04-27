#ARM L.L.T. - Light Laser Tower
#ARMLLT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TALightLaser = import('/mods/SCTA-master/lua/TAweapon.lua').TALightLaser

ARMLLT = Class(TAStructure) {
	Weapons = {
		ARM_LIGHTLASER = Class(TALightLaser) {

		},
	},
}

TypeClass = ARMLLT
