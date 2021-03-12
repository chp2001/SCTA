#ARM Millennium - Battleship
#ARMBATS
#
#Script created by Raevn

local TASea = import('/mods/SCTA-master/lua/TAMotion.lua').TASea
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMBATS = Class(TASea) {
	Weapons = {
		ARM_BATSa = Class(TAweapon) {
		},
		ARM_BATSb = Class(TAweapon) {
		},
	},
}

TypeClass = ARMBATS
