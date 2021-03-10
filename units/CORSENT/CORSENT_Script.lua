#ARM Phalanx - Mobile Flak Vehicle
#ARMYORK
#
#Script created by Raevn

local TATreads = import('/mods/SCTA-master/lua/TAMotion.lua').TATreads
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSENT = Class(TATreads) {
	Weapons = {
		ARMYORK_GUN = Class(TAweapon) {

		},
	},
}

TypeClass = CORSENT
