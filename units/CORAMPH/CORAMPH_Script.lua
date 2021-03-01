#ARM Pelican - Amphibious Kbot
#ARMAMPH
#
#Script created by Axle

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon


CORAMPH = Class(TAWalking) {

	Weapons = {
		armamph_weapon2 = Class(TAweapon) {

		},
		armamph_weapon1 = Class(TAweapon) {

		},
	},
}

TypeClass = CORAMPH
