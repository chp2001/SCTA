#ARM Jeffy - Fast Attack Vehicle
#ARMFAV
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMFAV = Class(TAunit) {

	Weapons = {
		ARM_LASER = Class(TAweapon) {
		},
	},
}

TypeClass = ARMFAV