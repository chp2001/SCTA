#ARM Bulldog - Heavy Assault Tank
#ARMBULL
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMBULL = Class(TAunit) {

	Weapons = {
		ARM_BULL = Class(TAweapon) {

		},
	},
}
TypeClass = ARMBULL
