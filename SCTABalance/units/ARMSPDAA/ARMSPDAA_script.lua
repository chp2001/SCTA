#ARM Spider - Spider Assault Vehicle
#ARMBULL
#
#Script created by Raevn


local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAweapon = import('/mods/SCTA-master/lua/TAweapon.lua').TAweapon

ARMSPDAA = Class(TAWalking) {

	Weapons = {
			WEAPON = Class(TAweapon) {},
		},
	}
TypeClass = ARMSPDAA
