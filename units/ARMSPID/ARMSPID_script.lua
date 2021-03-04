#ARM Spider - Spider Assault Vehicle
#ARMBULL
#
#Script created by Raevn

local TABACounter = import('/mods/SCTA-master/lua/TAMotion.lua').TABACounter
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSPID = Class(TABACounter) {

	Weapons = {
		ARM_PARALYZER = Class(TAweapon) {

		},
	},
}
TypeClass = ARMSPID
