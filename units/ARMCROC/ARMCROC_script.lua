#ARM Triton - Amphibious Tank
#ARMCROC
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMCROC = Class(TAunit) {

	Weapons = {
		ARM_MEDIUMCANNON = Class(TAweapon) {

		},
	},
}
TypeClass = ARMCROC