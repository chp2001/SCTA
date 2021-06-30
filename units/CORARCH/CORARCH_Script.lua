#ARM Archer - Anti-Air Ship
#ARMAAS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORARCH = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = CORARCH
