#ARM Spider - Spider Assault Vehicle
#ARMBULL
#
#Script created by Raevn

local TACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSPID = Class(TACounter) {

	Weapons = {
		ARM_PARALYZER = Class(TAweapon) {

		},
	},
}
TypeClass = ARMSPID
