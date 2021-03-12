#ARM Flash - Fast Assault Tank
#ARMFLASH
#
#Script created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMFLASH = Class(TAunit) {

	Weapons = {
		EMG = Class(TAweapon) {
		},
	},
}

TypeClass = ARMFLASH
