#ARM Pelican - Amphibious Kbot
#ARMAMPH
#
#Script created by Axle

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon


CORAMPH = Class(TAWalking) {

	Weapons = {
		WEAPON = Class(TAweapon) {},
	},
}

TypeClass = CORAMPH
