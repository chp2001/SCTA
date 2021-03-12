#ARM Warrior - Medium Infantry Kbot
#ARMWAR
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMWAR = Class(TAWalking) {
	
	Weapons = {
		ARMWAR_EMG = Class(TAweapon) {

		},
		ARMWAR_LCANNON = Class(TAweapon) {

		},
	},
}

TypeClass = ARMWAR
