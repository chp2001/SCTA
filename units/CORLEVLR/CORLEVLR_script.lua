#CORE Leveler - Riot Tank
#CORLEVLR
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORLEVLR = Class(TAunit) {

	Weapons = {
		CORLEVLR_WEAPON = Class(TAweapon) {

		},
	},
}
TypeClass = CORLEVLR