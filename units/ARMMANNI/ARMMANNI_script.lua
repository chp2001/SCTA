#ARM Penetrator - Mobile Energy Weapon
#ARMMANNI
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMMANNI = Class(TAunit) {

	Weapons = {
		ARMMANNI_WEAPON = Class(TAweapon) {},
	},
}
TypeClass = ARMMANNI
