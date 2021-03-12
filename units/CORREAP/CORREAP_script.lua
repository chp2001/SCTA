#CORE Reaper - Heavy Assault Tank
#CORREAP
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORREAP = Class(TAunit) {

	Weapons = {
		CORE_REAP = Class(TAweapon) {

		},
	},
}
TypeClass = CORREAP
