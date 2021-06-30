#ARM Skimmer - Scout Hovercraft
#ARMSH
#
#Script created by Raevn
local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSH = Class(TASea) {
	Weapons = {
		ARMSH_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = ARMSH
