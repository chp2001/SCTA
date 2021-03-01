#ARM Archer - Anti-Air Ship
#ARMAAS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORARCH = Class(TASea) {
	Weapons = {
		ARMAAS_WEAPON1 = Class(TAweapon) {},
		ARMAAS_WEAPON2 = Class(TAweapon) {},
		ARMAAS_WEAPON3 = Class(TAweapon) {},
	},
}

TypeClass = CORARCH
