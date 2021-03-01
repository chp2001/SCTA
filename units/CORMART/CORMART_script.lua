#CORE Pillager - Mobile Artillery
#CORMART
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORMART = Class(TAunit) {

	Weapons = {
		CORE_ARTILLERY = Class(TAweapon) {

		},
	},
}
TypeClass = CORMART