#ARM Zipper - Fast Attack Kbot
#ARMFAST
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSNIPE = Class(TACounter) {
	Weapons = {
		ARM_FAST = Class(TAweapon) {
		},
	},
}
TypeClass = ARMSNIPE