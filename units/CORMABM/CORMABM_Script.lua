#ARM Jeffy - Fast Attack Vehicle
#CORMABM
#
#Blueprint created by Raevn

local TAunit = import('/mods/SCTA-master/lua/TAunit.lua').TAunit
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon
CORMABM = Class(TAunit) {

	Weapons = {
			Turret01 = Class(TAMPhalanxWeapon) {},
	},
}

TypeClass = CORMABM