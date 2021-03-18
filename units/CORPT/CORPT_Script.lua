#CORE Searcher - Scout Ship
#CORPT
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORPT = Class(TASea) {
	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = CORPT
