#ARM Flash - Fast Assault Tank
#ARMFLASH
#
#Script created by Raevn

local TATreads = import('/mods/SCTA-master/lua/TAMotion.lua').TATreads
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMFLASH = Class(TATreads) {
	Weapons = {
		EMG = Class(TAweapon) {},
	},
}

TypeClass = ARMFLASH
