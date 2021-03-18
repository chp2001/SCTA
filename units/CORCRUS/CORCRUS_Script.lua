#CORE Executioner - Cruiser
#CORCRUS
#
#Script created by Raevn
local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORCRUS = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = CORCRUS
