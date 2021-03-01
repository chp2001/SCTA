#ARM Millennium - Battleship
#ARMBATS
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMBATS = Class(TAunit) {
	Weapons = {
		ARM_BATSa = Class(TAweapon) {

		},

		ARM_BATSb = Class(TAweapon) {

		},

	},
}

TypeClass = ARMBATS
