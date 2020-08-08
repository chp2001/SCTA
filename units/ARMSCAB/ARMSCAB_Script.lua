#ARM Scarab - Anti Missile
#ARMSCAB
#
#Blueprint created by Dragun

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp
ARMSCAB = Class(TAunit) {
	Weapons = {
			Turret01 = Class(AAMWillOWisp) {}
	},
}

TypeClass = ARMSCAB