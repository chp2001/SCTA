#ARM Archer - Anti-Air Ship
#ARMAAS
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMAAS = Class(TAunit) {
	Weapons = {
			WEAPON = Class(TAweapon) {},
		},
}

TypeClass = ARMAAS
