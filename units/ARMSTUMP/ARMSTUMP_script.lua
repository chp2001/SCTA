#ARM Stumpy - Medium Assault Tank
#ARMSTUMP
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSTUMP = Class(TAunit) {

	Weapons = {
		ARM_LIGHTCANNON = Class(TAweapon) {

		},
	},
}
TypeClass = ARMSTUMP