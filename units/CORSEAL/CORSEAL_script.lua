#CORE Crock - Amphibious Tank
#CORSEAL
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSEAL  = Class(TAunit) {

	Weapons = {
		CORE_MEDIUMCANNON = Class(TAweapon) {

		},
	},
}
TypeClass = CORSEAL