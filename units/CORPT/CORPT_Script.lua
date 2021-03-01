#CORE Searcher - Scout Ship
#CORPT
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORPT = Class(TASea) {
	Weapons = {
		CORPT_LASER = Class(TAweapon) {

		},
		CORKBOT_MISSILE = Class(TAweapon) {},
	},
}

TypeClass = CORPT
