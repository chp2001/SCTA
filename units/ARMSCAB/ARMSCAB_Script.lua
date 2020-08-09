#ARM Scarab - Anti Missile
#ARMSCAB
#
#Blueprint created by Dragun

local TAWalking = import('/mods/SCTA-master/lua/TAWalking.lua').TAWalking
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp
ARMSCAB = Class(TAWalking) {
	Weapons = {
			Turret01 = Class(AAMWillOWisp) {}
	},
}

TypeClass = ARMSCAB