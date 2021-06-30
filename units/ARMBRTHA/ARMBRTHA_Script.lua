#ARM Big Bertha - Long Range Plasma Cannon
#ARMBRTHA
#
#Script created by Raevn

local TAStructure = import('/mods/SCTA-master/lua/TAStructure.lua').TAStructure
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMBRTHA = Class(TAStructure) {
	Weapons = {
		ARM_BERTHACANNON = Class(TAweapon) {

		},
	},
}

TypeClass = ARMBRTHA
