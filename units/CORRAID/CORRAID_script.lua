#CORE Raider - Medium Assault Tank
#CORRAID
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORRAID = Class(TAunit) {

	Weapons = {
		CORE_LIGHTCANNON = Class(TAweapon) {

		},
	},
}
TypeClass = CORRAID