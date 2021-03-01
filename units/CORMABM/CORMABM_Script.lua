#ARM Jeffy - Fast Attack Vehicle
#CORMABM
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local AAMWillOWisp = import('/lua/aeonweapons.lua').AAMWillOWisp

CORMABM = Class(TAunit) {
	Weapons = {
			Turret01 = Class(AAMWillOWisp) {}
	},
}

TypeClass = CORMABM