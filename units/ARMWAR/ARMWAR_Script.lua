#ARM Warrior - Medium Infantry Kbot
#ARMWAR
#
#Script created by Raevn

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMWAR = Class(TAWalking) {
	Weapons = {
		ARMWAR_LCANNON = Class(TAweapon) {
		},
		ARMWAR_EMG = Class(TAweapon) {
		},
	},
}

TypeClass = ARMWAR
