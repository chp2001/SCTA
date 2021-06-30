#COR Swatter - Anti-Air Hovercraft
#CORAH
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORAH = Class(TASea) {
	Weapons = {
		CORAH_WEAPON = Class(TAweapon) {}
	},
}

TypeClass = CORAH
