#CORE Light Laser Tower - Light Laser Tower
#CORLLT
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TALightLaser = import('/mods/SCTA-master/lua/TAweapon.lua').TALightLaser

CORLLT = Class(TAStructure) {
	Weapons = {
		CORE_LIGHTLASER = Class(TALightLaser) {

		},
	},
}

TypeClass = CORLLT
