#COR Skimmer - Scout Hovercraft
#CORSH
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

CORSH = Class(TASea) {
	Weapons = {
		CORSH_WEAPON = Class(TAweapon) {

		},
	},
}

TypeClass = CORSH
