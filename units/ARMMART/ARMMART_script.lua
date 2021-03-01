#ARM Luger - Mobile Artillery
#ARMMART
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMMART = Class(TAunit) {

	Weapons = {
		ARM_ARTILLERY = Class(TAweapon) {

		},
	},
}
TypeClass = ARMMART