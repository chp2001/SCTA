#ARM Scarab - Anti Missile
#CORMABM
#
#Blueprint created by Raevn

local TATreads = import('/mods/SCTA-master/lua/TATread.lua').TATreads
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp
ARMSCAB = Class(TATreads) {
	Weapons = {
			Turret01 = Class(AAMWillOWisp) {}
	},
}

TypeClass = ARMSCAB