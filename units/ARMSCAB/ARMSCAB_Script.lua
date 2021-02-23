#ARM Scarab - Anti Missile
#ARMSCAB
#
#Blueprint created by Dragun

local TAWalking = import('/mods/SCTA-master/lua/TAMotion.lua').TAWalking
local TAMPhalanxWeapon = import('/lua/terranweapons.lua').TAMPhalanxWeapon

ARMSCAB = Class(TAWalking) {
	Weapons = {
			Turret01 = Class(TAMPhalanxWeapon) {}
	},
}

TypeClass = ARMSCAB